import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.SocketAddress;
import java.util.ArrayList;

import tcdIO.Terminal;

/*
 * Author: Daniel Nugent
* Student Number: 18326304
 */
public class Broker extends Node {
	static final int DEFAULT_PORT = 50001;
	static final String C_AND_C_ADDRESS = "/127.0.0.1:50002";
	ArrayList<WorkerContent> workers = new ArrayList<WorkerContent>();
	Terminal terminal;
	ArrayList<String> workersFromCAndC;
	boolean awaitingWork = false;
	boolean sendToAll = true;


	Broker(Terminal terminal, int port) {
		try {
			this.terminal = terminal;
			socket = new DatagramSocket(port);
			listener.go();
		} catch (java.lang.Exception e) {
			e.printStackTrace();
		}
	}

	public ArrayList<String> inputToWorkers(String input) { // converts String of workers to arraylist
		ArrayList<String> workers = new ArrayList<String>();
		String worker = "";
		for (int i = 0; i < input.length(); i++) {
			char c = input.charAt(i);
			if (c == ',') {
				workers.add(worker);
				worker = "";
			} else if (c != ' ' && c != ',') {
				worker += c;
			}

			if (i == input.length() - 1) {
				workers.add(worker);
			}
		}
		return workers;
	}

	public boolean isRegisteredWorker(String address) {
		for (WorkerContent worker : workers) {
			if (worker.getSocketAddress().toString().contains(address)) {
				return true;
			}
		}
		return false;
	}

	public boolean unRegisterWorker(String address) {
		for (WorkerContent worker : workers) {
			if (worker.getSocketAddress().toString().contains(address)) {
				workers.remove(worker);
				return true;
			}
		}
		return false;
	}
	public String getWorkerName(String address) {
		for (WorkerContent worker : workers) {
			if (worker.getSocketAddress().toString().contains(address)) {
				return worker.getName();
			}
		}
		return "";
	}

	public synchronized void dispatchMessageToWorkers(ArrayList<String> names, String messageContent) {
		try {
			DatagramPacket message;
			message = (new StringContent(messageContent)).toDatagramPacket();
			if (names == null) { // send message to all workers
				for (WorkerContent worker : workers) {
					message.setSocketAddress(worker.getSocketAddress());
					socket.send(message);
				}
			} else { // send message to worker name in question
				for (WorkerContent worker : workers) {
					for (String name : names) {
						if (worker.getName().toLowerCase().contains(name.toLowerCase())) { //ignore case
							message.setSocketAddress(worker.getSocketAddress());
							socket.send(message);
							break;
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public synchronized void onReceipt(DatagramPacket packet) {
		try {
			SocketAddress address = packet.getSocketAddress(); // if message is from C & C
			DatagramPacket message;
			StringContent content = new StringContent(packet);
			if (address.toString().contains(C_AND_C_ADDRESS)) {
				if (!awaitingWork && sendToAll) {
					String type = content.toString();
					if (type.contains("yes")) {
						sendToAll = true;
						awaitingWork = true;
					} else {
						sendToAll = false;
					}
					terminal.println(
							"Got type from C & C: " + (sendToAll ? "Sending to all" : "Sending to selected workers"));
					message = (new StringContent("ackowledged type: "
							+ (sendToAll ? "Sending to all" : "Sending to selected workers") + "\n"))
									.toDatagramPacket();

					message.setSocketAddress(address);
					socket.send(message);

				} else if (!awaitingWork && !sendToAll) {

					String workers = content.toString();
					workers = workers.replace("?", "");
					workersFromCAndC = inputToWorkers(workers);
					for (String worker : workersFromCAndC) {
						System.out.println("a worker: " + worker);
					}
					message = (new StringContent("workers received by broker\n")).toDatagramPacket();
					message.setSocketAddress(address);
					socket.send(message);
					awaitingWork = true;
				}

				else if (awaitingWork) {
					String workDescription = content.toString();
					String parsedDescription = workDescription.replaceAll("[^.,A-Za-z0-9 ]", "") + "\n";
					terminal.println("Dispatching message: ");
					if (sendToAll) {
						awaitingWork = false;
						sendToAll = true;
						dispatchMessageToWorkers(null, parsedDescription);

					} else {
						awaitingWork = false;
						sendToAll = true;
						dispatchMessageToWorkers(workersFromCAndC, parsedDescription);
					}
				}

			} else if (isRegisteredWorker(address.toString())) { // worker is replying
				String workerMsg = content.toString().replaceAll("[^\"!:.,A-Za-z0-9 ]", "");
				String workerName = getWorkerName(address.toString());
				if(workerMsg.contains("withdraw")) {
					unRegisterWorker(address.toString());
					terminal.println("worker unregistered:" + workerName);
					message = (new StringContent("Broker: You are no longer working")).toDatagramPacket();
					message.setSocketAddress(address);
					socket.send(message);
				}
				else {
					String messageFormatted = workerName + " " + workerMsg + "\n";
					terminal.print(workerName);
					terminal.println(": " + workerMsg);				
				}
			} else { // adding workers
				String workerName = content.toString().replace('?', ' ');
				terminal.println("worker connected:" + workerName);
				message = (new StringContent("You are connected\n")).toDatagramPacket();
				WorkerContent worker = new WorkerContent(address, workerName);
				workers.add(worker);
				message.setSocketAddress(address);
				socket.send(message);
				terminal.println(address.toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public synchronized void start() throws Exception {
		terminal.println("Waiting for contact");
		this.wait();
	}

	/*
	 * 
	 */
	public static void main(String[] args) {
		try {
			Terminal terminal = new Terminal("Broker");
			(new Broker(terminal, DEFAULT_PORT)).start();
			terminal.println("Program completed");
		} catch (java.lang.Exception e) {
			e.printStackTrace();
		}
	}
}
