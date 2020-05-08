
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
 * This class implements the competition using Dijkstra's algorithm
 */
import java.io.*;
import java.util.*;


	/**
	 * @param filename:
	 *            A filename containing the details of the city road network
	 * @param sA,
	 *            sB, sC: speeds for 3 contestants
	 */
	class CompetitionDijkstra {
		//Private member variables
	    private int N;
	    private int S;
	    private int sA;
	    private int sB;
	    private int sC;
	    private EdgeDiGraph G;

	    /**
	     * @param filename: A filename containing the details of the city road network
	     * @param sA,       sB, sC: speeds for 3 contestants
	     */
	    CompetitionDijkstra(String filename, int sA, int sB, int sC) {
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
							if (lN == 0) {
								N = Integer.parseInt(l);
							} else if (lN == 1) {
								S = Integer.parseInt(l);
								G = new EdgeDiGraph(N, S);
							} else {
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

	    /**
	     * @return int: minimum minutes that will pass before the three contestants can meet
	     */
	    int timeRequiredforCompetition() {
	        if (G != null) {
	            if(sA < 50 || sB < 50 || sC < 50
	                    || sA > 100 || sB > 100 || sC > 100) return -1;

	            double[][] dists = new double[G.V][G.V];
	            for (int i = 0; i < G.V; i++) {
	                dists[i] = getShortestAtVertex(i);
	            }

	            double d = getLargestDistance(dists);
	            if (Double.POSITIVE_INFINITY == d || d == 0) return -1;
	                int slowest = getSlowestSpeed();
	                slowest = (int) Math.ceil((d * 1000) / slowest);
	                return slowest;
	        }

	        return -1;
	    }

	    private int getSlowestSpeed() {
	        int[] nums = new int[]{sA, sB, sC};
	        Arrays.sort(nums);
	        return nums[0];
	    }

	    private double getLargestDistance(double[][] dists) {
	        double largest = 0;
	        for (double[] array : dists) {
	            for (double dist : array) {
	                if (largest < dist)
	                    largest = dist;
	            }
	        }

	        return largest;
	    }

	    private double[] getShortestAtVertex(int i) {
	        double[] distTo = new double[G.V];

	        for (int v = 0; v < G.V; v++)
	            distTo[v] = Double.POSITIVE_INFINITY;
	        distTo[i] = 0.0;

	        Comparator<Trail> comparator = new MyComparator();
	        PriorityQueue<Trail> trails = new PriorityQueue<Trail>(G.V, comparator);

	        trails.add(new Trail(i, distTo[i]));
	        while (!trails.isEmpty()) {
	        	Trail path = trails.poll();
	            for (DirectedEdge edge : G.adj[path.v]) {
	                int v = edge.v;
	                int w = edge.w;
	                if (distTo[w] > distTo[v] + edge.weight) {
	                    distTo[w] = distTo[v] + edge.weight;

	                    if (!alternateContains(trails, w)) {
	                    	trails.add(new Trail(w, distTo[w]));
	                    } else {
	                    	trails = replaceSpecial(trails, w, distTo[w]);
	                    }
	                }
	            }
	        }

	        return distTo;
	    }

	    private PriorityQueue<Trail> replaceSpecial(PriorityQueue<Trail> trails, int w, double newWeight) {
	        for (Trail trail : trails) {
	            if (trail.v == w) {
	            	trails.remove(trail);
	            	trail.weight = newWeight;
	                trails.add(trail);
	                break;
	            }
	        }

	        return trails;
	    }

	    private boolean alternateContains(PriorityQueue<Trail> trails, int w) {
	        for (Trail trail : trails) {
	            if (trail.v == w)
	                return true;
	        }
	        return false;
	    }
	

	}