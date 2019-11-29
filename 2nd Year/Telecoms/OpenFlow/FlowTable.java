import java.util.*;

public class FlowTable {
	public ArrayList<int[]> routerTable = new ArrayList<int[]>();
	private int routerNo;
	private boolean forUtility;

	public FlowTable(int router) {
		this.routerNo = router;
	}

	public FlowTable(boolean b) {
		forUtility = b;
	}

	public int getEndUser(int port) {
		return port - (CONSTANT.END_USER_PORT - 1);
	}

	public int getEndUserPort(int n) {
		return n + (CONSTANT.END_USER_PORT - 1);
	}

	public int getRouter(int port) {
		return port - (CONSTANT.DEFAULT_ROUTER_PORT - 1);
	}

	public int getRouterPort(int n) {
		return n + (CONSTANT.DEFAULT_ROUTER_PORT - 1);
	}

	// Table: | dst user | next router |
	// | PORT | PORT |
	public void newRow(int dstUser, int dstRouter) {
		int[] temp = new int[2];
		temp[0] = dstUser;
		temp[1] = dstRouter;
		routerTable.add(temp);
	}

	public boolean containsRow(int dstUser) {
		for (int i = 0; i < routerTable.size(); i++) {
			if (routerTable.get(i)[0] == dstUser)
				return true;
		}
		return false;
	}

	public int getNextPort(int dst) {
		for (int[] a : routerTable) {
			if (a[0] == dst) {
				if (a[1] == CONSTANT.PACKET_OUT_ROUTER) {
					return getEndUserPort(a[0]);
				} else {
					return getRouterPort(a[1]);
				}
			}
		}
		return -1; // not found
	}

	public boolean isEndUser(int port) {
		return (port >= CONSTANT.END_USER_PORT) && (port <= CONSTANT.END_USER_PORT + 100);
	}

}
