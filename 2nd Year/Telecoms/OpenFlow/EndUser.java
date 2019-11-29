import java.net.DatagramSocket;
import java.io.IOException;
import java.net.DatagramPacket;
import java.net.InetSocketAddress;

public class EndUser extends Node {
	static final String DEFAULT_DST_NODE = "localhost"; // Name of the host for the server
	static final int DST_USER = 2;
	static final int HEADER_LENGTH = 4; // Fixed length of the header
	
	static final int TYPE_POS = 0; // Position of the type within the header
	static final int NEXT_ROUTER = 3;
	static final byte TYPE_UNKNOWN = 0;
	static final byte TYPE_STRING = 1; // Indicating a string payload
	
	static final int LENGTH_POS = 1;
	static final byte TYPE_ACK = 2; // Indicating an acknowledgement
	static final int ACKCODE_POS = 1; // Position of the acknowledgement type in the header
	static final byte ACK_ALLOK = 10; // Inidcating that everything is ok

	Terminal terminal;
	InetSocketAddress dstAddress;
	FlowTable x = new FlowTable(true);
	int router;
	int number;
	String validUsers;
	boolean connected = false;

	EndUser(Terminal terminal, int port, int router, int number) {
		try {
			this.terminal = terminal;
			this.router = CONSTANT.DEFAULT_ROUTER_PORT + router - 1;
			this.number = number;
			socket = new DatagramSocket(port);
			listener.go();
		} catch (java.lang.Exception e) {
		}
	}

	/**
	 * Assume that incoming packets contain a String and print the string.
	 */
	public synchronized void onReceipt(DatagramPacket packet) {
		byte[] data;

		data = packet.getData();
		byte[] buffer;

		switch (data[TYPE_POS]) {
		case CONSTANT.OFPT_HELLO:
			if (packet.getPort() == CONSTANT.SERVER_PORT) {
				terminal.println("Successfully connected");
				this.connected = true;
			} else {
				terminal.println("Unexpected packet" + packet.toString());
			}
			break;
		case TYPE_ACK:
			terminal.println("Received ack");
			this.notify();
			break;
		case CONSTANT.OFPT_FEATURES_REPLY:
			buffer = new byte[data[LENGTH_POS]];
			System.arraycopy(data, HEADER_LENGTH, buffer, 0, buffer.length);
			String content = new String(buffer);
			terminal.println(content);
			validUsers = content;
			break;
		case CONSTANT.OFPT_PACKET_OUT:
			buffer = new byte[data[LENGTH_POS]];
			System.arraycopy(data, HEADER_LENGTH, buffer, 0, buffer.length);
			content = new String(buffer);
			terminal.println(content);
			break;
		default:
			terminal.println("Unexpected packet" + packet.toString());
		}
	}

	/**
	 * Sender Method
	 *
	 */
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
			while (true) {
				terminal.println("Attempting to connect to server...");
				sendMessage(Integer.toString(this.number), CONSTANT.SERVER_PORT, 
						(byte) CONSTANT.OFPT_HELLO, (byte) 0);
				this.sleep(100); //wait for other threads (server) to setup
				while (true) {
					
					if (this.connected) {
						terminal.println("Enter a message: ");
						String message = terminal.read("> ");
						sendMessage("", CONSTANT.SERVER_PORT, (byte) CONSTANT.OFPT_FEATURES_REQUEST, (byte)0);
						terminal.println("Who to send to: ");
						String toInt = terminal.read("> ");
						if(validUsers.contains(toInt)) {
						int to = Integer.parseInt(toInt);
						int user = x.getEndUser(to);
						sendMessage(number + ": " + message, 
								router, (byte)CONSTANT.OFPT_PACKET_IN, (byte)user);
                        terminal.println("to endUser: " + user);
						}
						else {
							terminal.println("That's not a valid user");
						}
					}
				

				}
			}
		} catch (Exception e) {
		}
	}
}