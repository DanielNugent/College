import java.net.DatagramPacket;
/*
 *  * Author: Daniel Nugent
 * Student Number: 18326304
 */
public class StringContent implements PacketContent {
	String string;
	byte[]data;
	public StringContent(DatagramPacket packet) {
		byte[] data;	
		data= packet.getData();
		this.data = data;
		string = new String(data);
	}
	
	public StringContent(String string) {
		this.string = string;
	}
	
	public String toString() {
		return string;
	}
	public byte[] toBytes() {
		return data;
	}

	public DatagramPacket toDatagramPacket() {
		DatagramPacket packet= null;
		try {
			byte[] data= string.getBytes();
			packet= new DatagramPacket(data, data.length);
		}
		catch(Exception e) {e.printStackTrace();}
		return packet;
	}
}
