import java.net.DatagramSocket;
import java.io.IOException;
import java.net.DatagramPacket;
import java.net.InetSocketAddress;
import java.util.Arrays;

public class Router extends Node{
	static final String DEFAULT_DST_NODE = "localhost"; // Name of the host for the server

	static final int HEADER_LENGTH = 4; // Fixed length of the header
	static final int TYPE_POS = 0; // Position of the type within the header
	static final int DST_USER = 2;
	static final int NEXT_ROUTER = 3;
	static final byte TYPE_UNKNOWN = 0;

	static final byte TYPE_STRING = 1; // Indicating a string payload
	static final int LENGTH_POS = 1;

	static final byte TYPE_ACK = 2; // Indicating an acknowledgement
	static final int ACKCODE_POS = 1; // Position of the acknowledgement type in the header
	static final byte ACK_ALLOK = 10; // Inidcating that everything is ok

	Terminal terminal;
	InetSocketAddress dstAddress;
	FlowTable table;
	int number;
	String savedMessage;
	int savedDst;

	Router(Terminal terminal, int port, int number) {
		try {
			this.terminal = terminal;
			this.number = number;
			savedDst = -1;
			savedMessage = "";
			table = new FlowTable(number);
			socket = new DatagramSocket(port);
			listener.go();
		} catch (java.lang.Exception e) {

		}
	}

	/**
	 * Assume that incoming packets contain a String and print the string.
	 */
	public synchronized void onReceipt(DatagramPacket packet) {
		try {
			byte[] data;
			data = packet.getData();
			byte[] buffer;
			int port = packet.getPort();
			switch (data[TYPE_POS]) {
			case CONSTANT.OFPT_HELLO:
				if (packet.getPort() == CONSTANT.SERVER_PORT) {
					terminal.println("Successfully connected");
				} else {
					terminal.println("Unexpected packet" + packet.toString());
				}
				break;
			case TYPE_ACK:
				terminal.println("Received ack");
				this.notify();
				break;
			case CONSTANT.OFPT_PACKET_IN:
				int dst = data[DST_USER];
				buffer = new byte[data[LENGTH_POS]];
				System.arraycopy(data, HEADER_LENGTH, buffer, 0, buffer.length);
				String content = new String(buffer);
				if (port != CONSTANT.SERVER_PORT) {
					String forward = "forwarding...";
					terminal.println(forward);
				}
				if (table.containsRow(dst)) {
					int next = table.getNextPort(dst);
					if (!table.isEndUser(next)) {
						sendMessage(content, next, (byte) CONSTANT.OFPT_PACKET_IN, (byte) dst);
					} else {
						sendMessage(content, next, (byte) CONSTANT.OFPT_PACKET_OUT, (byte) dst);
					}
				} else {
					savedMessage = content;
					savedDst = dst;
					sendMessage(content, CONSTANT.SERVER_PORT, (byte) CONSTANT.OFPT_FLOW_MOD, (byte) dst);
				}
				break;
			case CONSTANT.OFPT_FLOW_MOD:
				dst = data[DST_USER];
				int nextRouter = data[NEXT_ROUTER];
				if (!table.containsRow(dst))
					table.newRow(dst, nextRouter);
				break;
			default:
				terminal.println("Unexpected packet" + packet.toString());
			}
		} catch (Exception e) {

		}
	}

	public synchronized void sendMessage(String input, int port, byte header, byte dstUser) {
		byte[] data = null;
		byte[] buffer = null;
		buffer = input.getBytes();
		data = new byte[HEADER_LENGTH + buffer.length];
		data[TYPE_POS] = header;
		data[LENGTH_POS] = (byte) buffer.length;
		data[DST_USER] = dstUser;

		System.arraycopy(buffer, 0, data, HEADER_LENGTH, buffer.length);

		DatagramPacket packet = new DatagramPacket(data, data.length);
		packet.setSocketAddress(new InetSocketAddress(DEFAULT_DST_NODE, port));

		try {
			socket.send(packet);
		} catch (IOException e) {

		}
	}

	public void run() {
		try {
			this.sleep(100);
			terminal.println("Attempting to connect to server...");
			sendMessage(Integer.toString(this.number), CONSTANT.SERVER_PORT, (byte) CONSTANT.OFPT_HELLO, (byte) 0);

		} catch (Exception e) {

		}
	}
}
