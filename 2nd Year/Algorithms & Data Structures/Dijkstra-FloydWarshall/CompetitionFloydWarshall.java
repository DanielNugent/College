
/*
 * A Contest to Meet (ACM) is a reality TV contest that sets three contestants at three random
 * city intersections. In order to win, the three contestants need all to meet at any intersection
 * of the city as fast as possible.
 * It should be clear that the contestants may arrive at the intersections at different times, in
 * which case, the first to arrive can wait until the others arrive.
 * From an estimated walking speed for each one of the three contestants, ACM wants to determine the
 * minimum time that a live TV broadcast should last to cover their journey regardless of the contestants’
 * initial positions and the intersection they finally meet. You are hired to help ACM answer this question.
 * You may assume the following:
 *     Each contestant walks at a given estimated speed.
 *     The city is a collection of intersections in which some pairs are connected by one-way
 * streets that the contestants can use to traverse the city.
 *
 * This class implements the competition using Floyd-Warshall algorithm
 */
import java.io.*;
import java.util.*;

public class CompetitionFloydWarshall {
	private int N;
	private int S;
	private int sA;
	private int sB;
	private int sC;
	private EdgeDiGraph G;

	/**
	 * @param filename:
	 *            A filename containing the details of the city road network
	 * @param sA,
	 *            sB, sC: speeds for 3 contestants
	 */
	CompetitionFloydWarshall(String filename, int sA, int sB, int sC) {
		this.sA = sA;
		this.sB = sB;
		this.sC = sC;

		BufferedReader br;
		try {
			if (filename != null) {
				br = new BufferedReader(new FileReader(filename));
				int lN = 0;
				try {
					String l = br.readLine();
					while (l != null) {
						//checks line one
						if (lN == 0) {
							N = Integer.parseInt(l);
						//checks line two
						} else if (lN == 1) {
							S = Integer.parseInt(l);
							G = new EdgeDiGraph(N, S);
						//other lines
						} else {
							//separate the parts
							String[] separated = l.trim().split("\\s+");
							G.addIntersection(Integer.parseInt(separated[0]), Integer.parseInt(separated[1]),
									Double.parseDouble(separated[2]));
						}

						lN++;
						l = br.readLine();
					}
				} catch (IOException e) {

				} finally {
					try {
						br.close();
					} catch (IOException e) {

					}
				}
			} else {
				G = null;
			}
		} catch (FileNotFoundException e) {
			G = null;
		}
	}

	private int getSlowestSpeed() {
		int[] nums = new int[] { sA, sB, sC };
		Arrays.sort(nums); // inbuilt java sort
		return nums[0];
	}

	private double getLargestDistance(double[][] dists) {
		double l = 0;
		for (double[] arr : dists) {
			for (double dist : arr) {
				if (l < dist)
					l = dist;
			}
		}
		return l;
	}

	/**
	 * @return int: minimum minutes that will pass before the three contestants can
	 *         meet
	 */
	public int timeRequiredforCompetition() {
		if (G != null) {
			if (sA < 50 || sB < 50 || sC < 50
            || sA > 100 || sB > 100 || sC > 100)
				return -1;
			double dist[][] = new double[G.V][G.V];
			DirectedEdge[][] edges = new DirectedEdge[G.V][G.V];

			// intialise each value in dist array to infinity
			for (int i = 0; i < G.V; i++) {
				for (int j = 0; j < G.V; j++) {
					dist[i][j] = Double.POSITIVE_INFINITY;
				}
			}
			for (int i = 0; i < G.V; i++) {
				for (DirectedEdge e : G.adj[i]) {
					dist[e.v][e.w] = e.weight;
					edges[e.v][e.w] = e;
				}
				// destroy edges to themselves
				if (dist[i][i] >= 0.0) {
					dist[i][i] = 0.0;
					edges[i][i] = null;
				}
			}
			for (int k = 0; k < G.V; k++) {

				for (int i = 0; i < G.V; i++) {
					// check for null
					if (edges[i][k] == null)
						continue;
					// If vertex k is on the shortest path from
					// i to j, then update the value of dist[i][j]
					for (int j = 0; j < G.V; j++) {
						if (dist[i][j] > dist[i][k] + dist[k][j]) {
							dist[i][j] = dist[i][k] + dist[k][j];
							edges[i][j] = edges[k][j];
						}
					}
				}
			}
			double d = getLargestDistance(dist);
			if (Double.POSITIVE_INFINITY == d || d == 0) return -1;
			int slowest = getSlowestSpeed();
			slowest = (int) Math.ceil((d * 1000) / slowest);
			return slowest;

		}
		return -1;
	}
	public static void main(String arg[]) {
		int time = new CompetitionFloydWarshall("C:\\Users\\Daniel\\eclipse-workspace\\AlgorithmsPath\\src\\input\\1000EWD.txt", 55, 80, 55).timeRequiredforCompetition();
        System.out.println(time);
	}
}