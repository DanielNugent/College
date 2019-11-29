import java.net.DatagramPacket;
/*
 *  * Author: Daniel Nugent
 * Student Number: 18326304
 */
public interface PacketContent {
	public String toString();
	public DatagramPacket toDatagramPacket();
}