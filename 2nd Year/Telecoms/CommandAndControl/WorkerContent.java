 /* Author: Daniel Nugent
 * Student Number: 18326304 */
import java.net.SocketAddress;

public class WorkerContent  {
	String name;
	SocketAddress address;
	
	public WorkerContent(SocketAddress address, String name) {
		this.address = address;
		this.name = name;	
	}
	public SocketAddress getSocketAddress(){
		return this.address;
	}
	public String getName() {
		return this.name;
	}		
}