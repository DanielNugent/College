import java.util.*;

class EdgeDiGraph {
    public int V;
    public int E;
    public HashSet<DirectedEdge>[] adj;
    public int[] indegree;

    EdgeDiGraph(int V, int E) {
        this.V = V;
        this.E = E;
        this.indegree = new int[V];

        adj = (HashSet<DirectedEdge>[]) new HashSet[V];
        for (int vertex = 0; vertex < V; vertex++)
            adj[vertex] = new HashSet<DirectedEdge>();
    }

    void addIntersection(int loc1, int loc2, double weight){
        
            validateVertex(loc1);
            validateVertex(loc2);

            DirectedEdge e = new DirectedEdge(loc1, loc2, weight);
            adj[loc1].add(e);
            indegree[loc2]++;
        

    }

    private void validateVertex(int vertex) {
        if (vertex < 0 || vertex >= V)
            throw new IllegalArgumentException("Vertex not valid");
    }
}