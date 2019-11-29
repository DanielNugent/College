import java.util.*;

public class RunProgram {
	public static void main(String args[]) {
		int nRouters = 4;
        //predefined routes
		ArrayList<int[]> info = new ArrayList<int[]>();
		//predefined routes (hardcoded) first and last index represent (src and dst user and middle are the routers).
        int[]a = {1, 1, 3, 3}; //src: 1 -> router 1 -> router 3 -> end user 3
        int[]b = {2, 2, 3, 3};
        int[]c = {1, 1, 2, 2};
        int[]d = {1, 1, 2, 3, 4, 4};
        int[]e = {2, 2, 3, 1, 4, 4};
        int[]f = {3, 3, 2, 3, 4, 4};
        info.add(a);
        info.add(b);
        info.add(c);
        info.add(d);
        info.add(e);
        info.add(f);

		new Thread(new Server(new Terminal("Server"), CONSTANT.SERVER_PORT, info)).start();
		
		for (int i = 1; i < nRouters +1; i++) {
			new Thread(new Router(new Terminal("Router: " + i), CONSTANT.DEFAULT_ROUTER_PORT + i - 1, i)).start();
		}
		for (int i = 1; i < nRouters +1; i++) {
			new Thread(new EndUser(new Terminal("End User: " + i), CONSTANT.END_USER_PORT+i-1, i, i)).start(); // last argument is																									// the router that																								// the end point is																									// connected to
		}
	}
}
