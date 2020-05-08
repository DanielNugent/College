import java.util.Comparator;

public class Trail {
    int v;
    double weight;

    Trail(int v, double weight){
        this.v = v;
        this.weight = weight;
    }

}

class MyComparator implements Comparator<Trail>{
    @Override
    public int compare(Trail t, Trail t2) {
        return Double.compare(t.weight, t2.weight);
    }
}