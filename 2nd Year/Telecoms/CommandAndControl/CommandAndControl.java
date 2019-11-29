import java.net.DatagramSocket;
import java.net.DatagramPacket;
import java.net.InetSocketAddress;
import java.util.ArrayList;

import tcdIO.*;

/**
 *
 * Client class
 *  * Author: Daniel Nugent
 * Student Number: 18326304
 * An instance accepts user input
 *
 */
public class CommandAndControl extends Node {
	static final int DEFAULT_SRC_PORT = 50002;
	static final int BROKER_PORT = 50001;
	static final String DEFAULT_DST_NODE = "localhost";

	Terminal terminal;
	InetSocketAddress dstAddress;

	/**
	 * Constructor
	 * 
	 * Attempts to create socket at given port and create an InetSocketAddress for
	 * the destinations
	 */
	CommandAndControl(Terminal terminal, String dstHost, int dstPort, int srcPort) {
		try {
			this.terminal = terminal;
			dstAddress = new InetSocketAddress(dstHost, dstPort);
			socket = new DatagramSocket(srcPort);
			listener.go();
		} catch (java.lang.Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * Assume that incoming packets contain a String and print the string.
	 */
	public synchronized void onReceipt(DatagramPacket packet) {
		StringContent content = new StringContent(packet);
		this.notify();
		terminal.println(content.toString());
	}

	public void sendWork(byte[] data, DatagramPacket packet) {
		try {
			String dataStr = (terminal.readString("Enter work description: "));
			dataStr += "\n";
			data = dataStr.getBytes();
			packet = new DatagramPacket(data, data.length, dstAddress);
			socket.send(packet);
			terminal.println("Work sent");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public synchronized void start() throws Exception {
		while (true) {
			byte[] data = null;
			DatagramPacket packet = null;
			String toAllWorkers = (terminal.readString("Send to all workers?(\"yes\"/\"no\"): "));
			data = toAllWorkers.getBytes();
			packet = new DatagramPacket(data, data.length, dstAddress);
			socket.send(packet);
			// send to all workers
			if (toAllWorkers.contains("yes")) {
				this.wait();
				sendWork(data, packet);
			} // send to some workers
			else if (toAllWorkers.contains("no")) { // to selected workers
				this.wait();
				String dataWorkers = (terminal.readString("Enter recipients (separated by commas and spaces): \n"));
				data = dataWorkers.getBytes();
				dataWorkers = dataWorkers.replaceAll("[^\\p{Alnum},\\s]", ""); // formats string properly
				terminal.println("Workers are:  " + dataWorkers);
				packet = new DatagramPacket(data, data.length, dstAddress);
				socket.send(packet);
				this.wait();
				sendWork(data, packet);
			} else {
				terminal.println("Invalid input");
			}
		}
	}

	public static void main(String[] args) {

		try {
			Terminal terminal = new Terminal("C & C");
			(new CommandAndControl(terminal, DEFAULT_DST_NODE, BROKER_PORT, DEFAULT_SRC_PORT)).start();
			terminal.println("Program completed");
		} catch (java.lang.Exception e) {
			e.printStackTrace();
		}
	}
}