import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetSocketAddress;
import java.util.ArrayList;
import java.util.Arrays;

public class Server extends Node{
	static final int HEADER_LENGTH = 4;
	static final int NEXT_ROUTER = 3;
	static final int DST_USER = 2;
	static final int TYPE_POS = 0;
	static final byte TYPE_UNKNOWN = 0;
	static final byte TYPE_STRING = 1;
	static final int LENGTH_POS = 1;
	static final byte TYPE_ACK = 2;
	static final int ACKCODE_POS = 1;
	static final byte ACK_ALLOK = 10;
	static final String DEFAULT_DST_NODE = "localhost"; // Name of the host for the server
	Terminal terminal;
	ArrayList<Integer> routers = new ArrayList<Integer>();
	ArrayList<Integer> endUsers = new ArrayList<Integer>();
	ArrayList<int[]> info;
	FlowTable routing;

	/*
	 * 
	 */
	Server(Terminal terminal, int port, ArrayList<int[]> info) {
		try {
			this.terminal = terminal;
			routing = new FlowTable(true);
			socket = new DatagramSocket(port);
			this.info = info;
			listener.go();
		} catch (java.lang.Exception e) {
		}
	}

	// {1,1,3,3}, {3,3,1,1}
	public void informRouters(int router, int dst) {
		try {
			for (int[] a : info) {
				if ((a[a.length - 1] == dst && a[1] == router) || (a[0] == dst && a[a.length - 2] == router)) {
					for (int i = 1; i < a.length; i++) {
						if ((i + 1) == a.length - 1) { // to a enduser
							sendMessage("", routing.getRouterPort(a[i]), (byte) CONSTANT.OFPT_FLOW_MOD,
									(byte) a[a.length - 1], (byte)CONSTANT.PACKET_OUT_ROUTER);
							sendMessage("", routing.getRouterPort(a[i]), (byte) CONSTANT.OFPT_FLOW_MOD,
									(byte) a[0], (byte) a[i-1]);

						} else {
							sendMessage("", routing.getRouterPort(a[i]), (byte) CONSTANT.OFPT_FLOW_MOD,
									(byte) a[a.length - 1], (byte) a[i + 1]);
							if (i - 1 == 0)
								sendMessage("", routing.getRouterPort(a[i]), (byte) CONSTANT.OFPT_FLOW_MOD, (byte) a[0],
										(byte)CONSTANT.PACKET_OUT_ROUTER);
							else {
								sendMessage("", routing.getRouterPort(a[i]), (byte) CONSTANT.OFPT_FLOW_MOD, (byte) a[0],
										(byte) a[i - 1]);
							}
						}
					}
					break;
				}
			}
		} catch (Exception e) {

		}
	}

	public synchronized void onReceipt(DatagramPacket packet) {
		try {
			String content;
			byte[] data;
			byte[] buffer;
			DatagramPacket response;
			data = packet.getData();
			int port = packet.getPort();
			switch (data[TYPE_POS]) {
			case CONSTANT.OFPT_HELLO:
				if (port >= CONSTANT.END_USER_PORT) {
					buffer = new byte[data[LENGTH_POS]];
					System.arraycopy(data, HEADER_LENGTH, buffer, 0, buffer.length);
					content = new String(buffer);
					terminal.println("End user " + content + " says hello. Port: " + port);
					sendMessage("", port, (byte) CONSTANT.OFPT_HELLO); // acknowledgement of connection
					if (!endUsers.contains(port)) {
						endUsers.add(port);
					}
				} else {
					buffer = new byte[data[LENGTH_POS]];
					System.arraycopy(data, HEADER_LENGTH, buffer, 0, buffer.length);
					content = new String(buffer);
					terminal.println("Router " + content + " says hello. Port: " + port);
					sendMessage("", port, (byte) CONSTANT.OFPT_HELLO); // acknowledgement of connection
					if (!routers.contains(port)) {
						routers.add(port);
					}
				}
				break;
			case CONSTANT.OFPT_FEATURES_REQUEST:
				terminal.println(
						"End User: " + (port - (CONSTANT.END_USER_PORT) + 1) + " is requesting to send a message.");
				ArrayList<Integer> temp = endUsers;
				int k = 0;
				for (int i = 0; i < temp.size(); i++) {
					if (temp.get(i) == port) {
						k = temp.get(i);
						temp.remove(i);
					}
				}
				sendMessage(temp.toString(), port, (byte) CONSTANT.OFPT_FEATURES_REPLY); // acknowledgement of
																							// connection
				temp.add(k);
				break;
			case CONSTANT.OFPT_FLOW_MOD:
				// router requesting info on how to route
				int dst = data[DST_USER];
				int router = routing.getRouter(port);
				terminal.println("updating routers flowtables...");
				informRouters(router, dst);
				buffer = new byte[data[LENGTH_POS]];
				System.arraycopy(data, HEADER_LENGTH, buffer, 0, buffer.length);
				content = new String(buffer);
				terminal.println(content);
				sendMessage(content, port, (byte)CONSTANT.OFPT_PACKET_IN, (byte)dst, (byte)0);
				break;
			default:
				terminal.println("Unexpected packet" + packet.toString());
			}

		} catch (Exception e) {
		}
	}

	public synchronized void sendMessage(String input, int port, byte header) {
		byte[] data = null;
		byte[] buffer = null;

		buffer = input.getBytes();

		data = new byte[HEADER_LENGTH + buffer.length];

		data[TYPE_POS] = header;
		data[LENGTH_POS] = (byte) buffer.length;

		System.arraycopy(buffer, 0, data, HEADER_LENGTH, buffer.length);

		DatagramPacket packet = new DatagramPacket(data, data.length);
		packet.setSocketAddress(new InetSocketAddress(DEFAULT_DST_NODE, port));

		try {
			socket.send(packet);
		} catch (IOException e) {
		}
	}

	public synchronized void sendMessage(String input, int port, byte header, byte dstUser, byte nextRouter) {
		byte[] data = null;
		byte[] buffer = null;

		buffer = input.getBytes();

		data = new byte[HEADER_LENGTH + buffer.length];
		data[TYPE_POS] = header;
		data[LENGTH_POS] = (byte)buffer.length;
		data[DST_USER] = dstUser;
		data[NEXT_ROUTER] = nextRouter;

		System.arraycopy(buffer, 0, data, HEADER_LENGTH, buffer.length);

		DatagramPacket packet = new DatagramPacket(data, data.length);
		packet.setSocketAddress(new InetSocketAddress(DEFAULT_DST_NODE, port));

		try {
			socket.send(packet);
		} catch (IOException e) {
		}
	}

	public void run() {
		terminal.println("Waiting for contact");
	}
}