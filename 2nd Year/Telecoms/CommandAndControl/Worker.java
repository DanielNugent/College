import java.net.DatagramSocket;
import java.net.DatagramPacket;
import java.net.InetSocketAddress;
import tcdIO.*;

/**
 * Worker
 * Author: Daniel Nugent
 * Student Number: 18326304
 */

public class Worker extends Node {
	static final int DEFAULT_SRC_PORT = 50003;
	static final int DEFAULT_DST_PORT = 50001;
	static final String DEFAULT_DST_NODE = "localhost";

	Terminal terminal;
	InetSocketAddress dstAddress;

	/**
	 * Constructor
	 * 
	 * Attempts to create socket at given port and create an InetSocketAddress for
	 * the destinations
	 */
	Worker(Terminal terminal, String dstHost, int dstPort, int srcPort) {
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
		try {
			StringContent content = new StringContent(packet);
			if (content.toString().contains("You are connected\n")) {
				terminal.println(content.toString());
			} 
			else if(content.toString().contains("You are no longer working")) {
				terminal.println(content.toString());
			}	
			else {
				terminal.println("C&C: " + content.toString());
				byte[] data = null;
				DatagramPacket response = null;
				String dataStr = (terminal.readString("Reply \"withdraw\" to stop working, or reply results:\n"));
				dataStr += "\n";
				data = dataStr.getBytes();
				response = new DatagramPacket(data, data.length, dstAddress);
				socket.send(response);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}


	public synchronized void start() throws Exception {
		byte[] data = null;
		DatagramPacket packet = null;
		String dataStr = (terminal.readString("Send \"yes\" to volunteer for work, \"no\" to not: "));
		dataStr += "\n";
		if (dataStr.contains("yes")) {
			String dataStr2 = (terminal.readString("Enter your name: "));
			data = dataStr2.getBytes();
			packet = new DatagramPacket(data, data.length, dstAddress);
			socket.send(packet);
			this.wait();
		} else {
			terminal.println("No work for you today");
		}
	}

	public static void main(String[] args) {
		try {
			Terminal terminal = new Terminal("Worker");
			(new Worker(terminal, DEFAULT_DST_NODE, DEFAULT_DST_PORT, DEFAULT_SRC_PORT)).start();
			terminal.println("Program completed");
		} catch (java.lang.Exception e) {
			e.printStackTrace();
		}
	}
}
