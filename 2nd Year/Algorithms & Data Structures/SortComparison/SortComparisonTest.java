/*                  | Insertion | Selection | Merge Rec | Merge It | Quicksort |
10 random           |  0.0049ms |  0.8162ms | 0.0122ms  | 0.0452ms | 0.0088ms  |
100 random          |  0.046ms  |  0.0795ms | 0.0559ms  | 0.039ms  | 0.0413ms  | 
1000 random         |  1.9078ms |  5.6079ms | 0.6218ms  | 0.7361ms | 0.7039ms  |
1000 few unique     |  4.5196ms |  0.4423ms | 0.1843ms  | 0.128ms  | 0.1171ms  |   
1000 nearly ordered |  0.0255ms |  0.307ms  | 0.1498ms  | 0.0685ms | 0.0876ms  |
1000 reverse order  |  0.3159ms |  0.4091ms | 0.1186ms  | 0.0585ms | 0.5098ms  |
1000 sorted         |  0.0022ms |  0.3425ms | 0.1332ms  | 0.0569ms | 0.5553ms  |

a) Insertion sort has the biggest impact when there are few unique numbers in the input. 
Mergesort recursive also takes a hit in this regard.
b)  Insertion sort ->  It can take a lot of compares when there are few unique inputs, 
causing the algorithm to run in o(n^2) with a high probability.
c) Quicksort has the best scalabilty. It is extremely good sorting algorithm.
Selection sort has the worst scalability, due to the nature of it when the numbers are randomly spread.
d) The recursive one is superior when the input gets large, but the iterative version is better when the 
input is small. However this can be disregarded as small inputs run instantaneously anyway. 
e) 10 random -> Insertion
   100 random -> Merge Iterative
   1000 random -> Quicksort
   1000 few unique -> Quicksort
   1000 nearly ord -> Merge Iterative
   1000 reverse order ->  Merge It
   1000 sorted -> Insertion
   

*/
import java.io.BufferedReader;
import org.hamcrest.core.IsEqual;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;
//-------------------------------------------------------------------------

@RunWith(JUnit4.class)
public class SortComparisonTest {
    @Test
    public void testConstructor() {
        new SortComparison();
    }
    @Test
    public void testSelection() {
        double[] a = new double[]{2910.66, 8458.14, 1522.08, 5855.37, 1934.75, 8106.23, 1735.31, 4849.83, 1518.63};
        double[] result = new double[]{1518.63, 1522.08, 1735.31, 1934.75, 2910.66, 4849.83, 5855.37, 8106.23, 8458.14};

        Assert.assertThat("Selection sort on 10 elements", SortComparison.selectionSort(a), IsEqual.equalTo(result));

        a = new double[]{2910.66, 8458.14, 1522.08, 5855.37, 1934.75, 8106.23, 1735.31, 4849.83, 1518.63, 3669.57,
                4917.36, 9100.94, 2652.57, 8931.88, 2203.51, 6317.98, 5710.77, 3321.58, 1044.55, 5029.31, 5673.94,
                8541.65, 401.409, 1080.22, 6393.96, 131.11, 7201.84, 1018.14, 4829.45, 2543.55, 6766.97, 8967.82,
                7598.96, 7202.92, 9076.23, 9286.11, 3776.63, 8997.56, 7788.8, 3242.55, 1942.31, 9955.53, 1612.96,
                7080.34, 5015.19, 9363.01, 7163.23, 1051.9, 2092.05, 5593.97, 7054.32, 782.337, 5105.3, 1961.97,
                2742.11, 6386.02, 4482.08, 398.718, 4672.51, 777.565, 381.004, 1600.44, 3978.32, 6888.98, 5347.12,
                6869.2, 2724.57, 4659.33, 2765.55, 4500.86, 9350.69, 869.318, 4538.89, 9456.25, 8557.19, 1209.76,
                141.639, 2345.15, 8663.13, 4373.9, 7695.48, 8740.03, 3769.34, 9443.28, 7984.93, 8386.34, 9466.56,
                5860.52, 5991.63, 3193.47, 4211.62, 9041.07, 1584.62, 8351.59, 7319.42, 4918.37, 2121.29, 1197.52,
                483.631};
        result = new double[]{131.11, 141.639, 381.004, 398.718, 401.409, 483.631, 777.565, 782.337, 869.318, 1018.14,
                1044.55, 1051.9, 1080.22, 1197.52, 1209.76, 1518.63, 1522.08, 1584.62, 1600.44, 1612.96, 1735.31, 1934.75,
                1942.31, 1961.97, 2092.05, 2121.29, 2203.51, 2345.15, 2543.55, 2652.57, 2724.57, 2742.11, 2765.55, 2910.66,
                3193.47, 3242.55, 3321.58, 3669.57, 3769.34, 3776.63, 3978.32, 4211.62, 4373.9, 4482.08, 4500.86, 4538.89,
                4659.33, 4672.51, 4829.45, 4849.83, 4917.36, 4918.37, 5015.19, 5029.31, 5105.3, 5347.12, 5593.97, 5673.94,
                5710.77, 5855.37, 5860.52, 5991.63, 6317.98, 6386.02, 6393.96, 6766.97, 6869.2, 6888.98, 7054.32, 7080.34,
                7163.23, 7201.84, 7202.92, 7319.42, 7598.96, 7695.48, 7788.8, 7984.93, 8106.23, 8351.59, 8386.34, 8458.14,
                8541.65, 8557.19, 8663.13, 8740.03, 8931.88, 8967.82, 8997.56, 9041.07, 9076.23, 9100.94, 9286.11, 9350.69,
                9363.01, 9443.28, 9456.25, 9466.56, 9955.53};


        Assert.assertThat("Selection sort on 100 elements", SortComparison.selectionSort(a), IsEqual.equalTo(result));

        assertNull("Null when null passed on Selection Sort", SortComparison.selectionSort(null));
    }

    @Test
    public void testInsertion() {
        double[] a = new double[]{2910.66, 8458.14, 1522.08, 5855.37, 1934.75, 8106.23, 1735.31, 4849.83, 1518.63};
        double[] result = new double[]{1518.63, 1522.08, 1735.31, 1934.75, 2910.66, 4849.83, 5855.37, 8106.23, 8458.14};

        Assert.assertThat("Insertion sort on 10 elements", SortComparison.insertionSort(a), IsEqual.equalTo(result));

        a = new double[]{2910.66, 8458.14, 1522.08, 5855.37, 1934.75, 8106.23, 1735.31, 4849.83, 1518.63, 3669.57,
                4917.36, 9100.94, 2652.57, 8931.88, 2203.51, 6317.98, 5710.77, 3321.58, 1044.55, 5029.31, 5673.94,
                8541.65, 401.409, 1080.22, 6393.96, 131.11, 7201.84, 1018.14, 4829.45, 2543.55, 6766.97, 8967.82,
                7598.96, 7202.92, 9076.23, 9286.11, 3776.63, 8997.56, 7788.8, 3242.55, 1942.31, 9955.53, 1612.96,
                7080.34, 5015.19, 9363.01, 7163.23, 1051.9, 2092.05, 5593.97, 7054.32, 782.337, 5105.3, 1961.97,
                2742.11, 6386.02, 4482.08, 398.718, 4672.51, 777.565, 381.004, 1600.44, 3978.32, 6888.98, 5347.12,
                6869.2, 2724.57, 4659.33, 2765.55, 4500.86, 9350.69, 869.318, 4538.89, 9456.25, 8557.19, 1209.76,
                141.639, 2345.15, 8663.13, 4373.9, 7695.48, 8740.03, 3769.34, 9443.28, 7984.93, 8386.34, 9466.56,
                5860.52, 5991.63, 3193.47, 4211.62, 9041.07, 1584.62, 8351.59, 7319.42, 4918.37, 2121.29, 1197.52,
                483.631};
        result = new double[]{131.11, 141.639, 381.004, 398.718, 401.409, 483.631, 777.565, 782.337, 869.318, 1018.14,
                1044.55, 1051.9, 1080.22, 1197.52, 1209.76, 1518.63, 1522.08, 1584.62, 1600.44, 1612.96, 1735.31, 1934.75,
                1942.31, 1961.97, 2092.05, 2121.29, 2203.51, 2345.15, 2543.55, 2652.57, 2724.57, 2742.11, 2765.55, 2910.66,
                3193.47, 3242.55, 3321.58, 3669.57, 3769.34, 3776.63, 3978.32, 4211.62, 4373.9, 4482.08, 4500.86, 4538.89,
                4659.33, 4672.51, 4829.45, 4849.83, 4917.36, 4918.37, 5015.19, 5029.31, 5105.3, 5347.12, 5593.97, 5673.94,
                5710.77, 5855.37, 5860.52, 5991.63, 6317.98, 6386.02, 6393.96, 6766.97, 6869.2, 6888.98, 7054.32, 7080.34,
                7163.23, 7201.84, 7202.92, 7319.42, 7598.96, 7695.48, 7788.8, 7984.93, 8106.23, 8351.59, 8386.34, 8458.14,
                8541.65, 8557.19, 8663.13, 8740.03, 8931.88, 8967.82, 8997.56, 9041.07, 9076.23, 9100.94, 9286.11, 9350.69,
                9363.01, 9443.28, 9456.25, 9466.56, 9955.53};

        Assert.assertThat("Selection sort on 100 elements", SortComparison.insertionSort(a), IsEqual.equalTo(result));

        assertNull("Null when null passed on Insertion Sort", SortComparison.insertionSort(null));
    }

    @Test
    public void testMergeSortIterative() {
        double[] a = new double[]{2910.66, 8458.14, 1522.08, 5855.37, 1934.75, 8106.23, 1735.31, 4849.83, 1518.63};
        double[] result = new double[]{1518.63, 1522.08, 1735.31, 1934.75, 2910.66, 4849.83, 5855.37, 8106.23, 8458.14};

        Assert.assertThat("MergeSort Iterative on 10 elements", SortComparison.mergeSortIterative(a), IsEqual.equalTo(result));

        a = new double[]{2910.66, 8458.14, 1522.08, 5855.37, 1934.75, 8106.23, 1735.31, 4849.83, 1518.63, 3669.57,
                4917.36, 9100.94, 2652.57, 8931.88, 2203.51, 6317.98, 5710.77, 3321.58, 1044.55, 5029.31, 5673.94,
                8541.65, 401.409, 1080.22, 6393.96, 131.11, 7201.84, 1018.14, 4829.45, 2543.55, 6766.97, 8967.82,
                7598.96, 7202.92, 9076.23, 9286.11, 3776.63, 8997.56, 7788.8, 3242.55, 1942.31, 9955.53, 1612.96,
                7080.34, 5015.19, 9363.01, 7163.23, 1051.9, 2092.05, 5593.97, 7054.32, 782.337, 5105.3, 1961.97,
                2742.11, 6386.02, 4482.08, 398.718, 4672.51, 777.565, 381.004, 1600.44, 3978.32, 6888.98, 5347.12,
                6869.2, 2724.57, 4659.33, 2765.55, 4500.86, 9350.69, 869.318, 4538.89, 9456.25, 8557.19, 1209.76,
                141.639, 2345.15, 8663.13, 4373.9, 7695.48, 8740.03, 3769.34, 9443.28, 7984.93, 8386.34, 9466.56,
                5860.52, 5991.63, 3193.47, 4211.62, 9041.07, 1584.62, 8351.59, 7319.42, 4918.37, 2121.29, 1197.52,
                483.631};
        result = new double[]{131.11, 141.639, 381.004, 398.718, 401.409, 483.631, 777.565, 782.337, 869.318, 1018.14,
                1044.55, 1051.9, 1080.22, 1197.52, 1209.76, 1518.63, 1522.08, 1584.62, 1600.44, 1612.96, 1735.31, 1934.75,
                1942.31, 1961.97, 2092.05, 2121.29, 2203.51, 2345.15, 2543.55, 2652.57, 2724.57, 2742.11, 2765.55, 2910.66,
                3193.47, 3242.55, 3321.58, 3669.57, 3769.34, 3776.63, 3978.32, 4211.62, 4373.9, 4482.08, 4500.86, 4538.89,
                4659.33, 4672.51, 4829.45, 4849.83, 4917.36, 4918.37, 5015.19, 5029.31, 5105.3, 5347.12, 5593.97, 5673.94,
                5710.77, 5855.37, 5860.52, 5991.63, 6317.98, 6386.02, 6393.96, 6766.97, 6869.2, 6888.98, 7054.32, 7080.34,
                7163.23, 7201.84, 7202.92, 7319.42, 7598.96, 7695.48, 7788.8, 7984.93, 8106.23, 8351.59, 8386.34, 8458.14,
                8541.65, 8557.19, 8663.13, 8740.03, 8931.88, 8967.82, 8997.56, 9041.07, 9076.23, 9100.94, 9286.11, 9350.69,
                9363.01, 9443.28, 9456.25, 9466.56, 9955.53};


        Assert.assertThat("MergeSort Iterative on 100 elements", SortComparison.mergeSortIterative(a), IsEqual.equalTo(result));

        assertNull("Null when null passed on MergeSort Iterative", SortComparison.mergeSortIterative(null));
    }

    @Test
    public void testMergeSortRecursive() {
        double[] a = new double[]{2910.66, 8458.14, 1522.08, 5855.37, 1934.75, 8106.23, 1735.31, 4849.83, 1518.63};
        double[] result = new double[]{1518.63, 1522.08, 1735.31, 1934.75, 2910.66, 4849.83, 5855.37, 8106.23, 8458.14};

        Assert.assertThat("MergeSort Recursive on 10 elements", SortComparison.mergeSortRecursive(a), IsEqual.equalTo(result));

        a = new double[]{2910.66, 8458.14, 1522.08, 5855.37, 1934.75, 8106.23, 1735.31, 4849.83, 1518.63, 3669.57,
                4917.36, 9100.94, 2652.57, 8931.88, 2203.51, 6317.98, 5710.77, 3321.58, 1044.55, 5029.31, 5673.94,
                8541.65, 401.409, 1080.22, 6393.96, 131.11, 7201.84, 1018.14, 4829.45, 2543.55, 6766.97, 8967.82,
                7598.96, 7202.92, 9076.23, 9286.11, 3776.63, 8997.56, 7788.8, 3242.55, 1942.31, 9955.53, 1612.96,
                7080.34, 5015.19, 9363.01, 7163.23, 1051.9, 2092.05, 5593.97, 7054.32, 782.337, 5105.3, 1961.97,
                2742.11, 6386.02, 4482.08, 398.718, 4672.51, 777.565, 381.004, 1600.44, 3978.32, 6888.98, 5347.12,
                6869.2, 2724.57, 4659.33, 2765.55, 4500.86, 9350.69, 869.318, 4538.89, 9456.25, 8557.19, 1209.76,
                141.639, 2345.15, 8663.13, 4373.9, 7695.48, 8740.03, 3769.34, 9443.28, 7984.93, 8386.34, 9466.56,
                5860.52, 5991.63, 3193.47, 4211.62, 9041.07, 1584.62, 8351.59, 7319.42, 4918.37, 2121.29, 1197.52,
                483.631};
        result = new double[]{131.11, 141.639, 381.004, 398.718, 401.409, 483.631, 777.565, 782.337, 869.318, 1018.14,
                1044.55, 1051.9, 1080.22, 1197.52, 1209.76, 1518.63, 1522.08, 1584.62, 1600.44, 1612.96, 1735.31, 1934.75,
                1942.31, 1961.97, 2092.05, 2121.29, 2203.51, 2345.15, 2543.55, 2652.57, 2724.57, 2742.11, 2765.55, 2910.66,
                3193.47, 3242.55, 3321.58, 3669.57, 3769.34, 3776.63, 3978.32, 4211.62, 4373.9, 4482.08, 4500.86, 4538.89,
                4659.33, 4672.51, 4829.45, 4849.83, 4917.36, 4918.37, 5015.19, 5029.31, 5105.3, 5347.12, 5593.97, 5673.94,
                5710.77, 5855.37, 5860.52, 5991.63, 6317.98, 6386.02, 6393.96, 6766.97, 6869.2, 6888.98, 7054.32, 7080.34,
                7163.23, 7201.84, 7202.92, 7319.42, 7598.96, 7695.48, 7788.8, 7984.93, 8106.23, 8351.59, 8386.34, 8458.14,
                8541.65, 8557.19, 8663.13, 8740.03, 8931.88, 8967.82, 8997.56, 9041.07, 9076.23, 9100.94, 9286.11, 9350.69,
                9363.01, 9443.28, 9456.25, 9466.56, 9955.53};


        Assert.assertThat("MergeSort Recursive on 100 elements", SortComparison.mergeSortRecursive(a), IsEqual.equalTo(result));

        assertNull("Null when null passed on MergeSort Recursive", SortComparison.mergeSortRecursive(null));
    }

    @Test
    public void testQuickSort() {
        double[] a = new double[]{2910.66, 8458.14, 1522.08, 5855.37, 1934.75, 8106.23, 1735.31, 4849.83, 1518.63};
        double[] result = new double[]{1518.63, 1522.08, 1735.31, 1934.75, 2910.66, 4849.83, 5855.37, 8106.23, 8458.14};

        Assert.assertThat("QuickSort on 10 elements", SortComparison.quickSort(a), IsEqual.equalTo(result));

        a = new double[]{2910.66, 8458.14, 1522.08, 5855.37, 1934.75, 8106.23, 1735.31, 4849.83, 1518.63, 3669.57,
                4917.36, 9100.94, 2652.57, 8931.88, 2203.51, 6317.98, 5710.77, 3321.58, 1044.55, 5029.31, 5673.94,
                8541.65, 401.409, 1080.22, 6393.96, 131.11, 7201.84, 1018.14, 4829.45, 2543.55, 6766.97, 8967.82,
                7598.96, 7202.92, 9076.23, 9286.11, 3776.63, 8997.56, 7788.8, 3242.55, 1942.31, 9955.53, 1612.96,
                7080.34, 5015.19, 9363.01, 7163.23, 1051.9, 2092.05, 5593.97, 7054.32, 782.337, 5105.3, 1961.97,
                2742.11, 6386.02, 4482.08, 398.718, 4672.51, 777.565, 381.004, 1600.44, 3978.32, 6888.98, 5347.12,
                6869.2, 2724.57, 4659.33, 2765.55, 4500.86, 9350.69, 869.318, 4538.89, 9456.25, 8557.19, 1209.76,
                141.639, 2345.15, 8663.13, 4373.9, 7695.48, 8740.03, 3769.34, 9443.28, 7984.93, 8386.34, 9466.56,
                5860.52, 5991.63, 3193.47, 4211.62, 9041.07, 1584.62, 8351.59, 7319.42, 4918.37, 2121.29, 1197.52,
                483.631};
        result = new double[]{131.11, 141.639, 381.004, 398.718, 401.409, 483.631, 777.565, 782.337, 869.318, 1018.14,
                1044.55, 1051.9, 1080.22, 1197.52, 1209.76, 1518.63, 1522.08, 1584.62, 1600.44, 1612.96, 1735.31, 1934.75,
                1942.31, 1961.97, 2092.05, 2121.29, 2203.51, 2345.15, 2543.55, 2652.57, 2724.57, 2742.11, 2765.55, 2910.66,
                3193.47, 3242.55, 3321.58, 3669.57, 3769.34, 3776.63, 3978.32, 4211.62, 4373.9, 4482.08, 4500.86, 4538.89,
                4659.33, 4672.51, 4829.45, 4849.83, 4917.36, 4918.37, 5015.19, 5029.31, 5105.3, 5347.12, 5593.97, 5673.94,
                5710.77, 5855.37, 5860.52, 5991.63, 6317.98, 6386.02, 6393.96, 6766.97, 6869.2, 6888.98, 7054.32, 7080.34,
                7163.23, 7201.84, 7202.92, 7319.42, 7598.96, 7695.48, 7788.8, 7984.93, 8106.23, 8351.59, 8386.34, 8458.14,
                8541.65, 8557.19, 8663.13, 8740.03, 8931.88, 8967.82, 8997.56, 9041.07, 9076.23, 9100.94, 9286.11, 9350.69,
                9363.01, 9443.28, 9456.25, 9466.56, 9955.53};


        Assert.assertThat("QuickSort on 100 elements", SortComparison.quickSort(a), IsEqual.equalTo(result));

        assertNull("Null when null passed on QuickSort", SortComparison.quickSort(null));
    }

    @Test
    public void testEmpty() {
        double[] emptyArray = new double[0];
        assertEquals(emptyArray, SortComparison.selectionSort(emptyArray));
        assertEquals(emptyArray, SortComparison.insertionSort(emptyArray));
        assertEquals(emptyArray, SortComparison.mergeSortIterative(emptyArray));
        assertEquals(emptyArray, SortComparison.mergeSortRecursive(emptyArray));
        assertEquals(emptyArray, SortComparison.quickSort(emptyArray));
    }
	public static void main(String[] args) {
    	String[] files = new String[]{"C://Users/Daniel/eclipse-workspace/AlgorithmsSort/src/input/numbers10.txt",
    			"C://Users/Daniel/eclipse-workspace/AlgorithmsSort/src/input/numbers100.txt",
    			"C://Users/Daniel/eclipse-workspace/AlgorithmsSort/src/input/numbers1000.txt",
    			"C://Users/Daniel/eclipse-workspace/AlgorithmsSort/src/input/numbers1000Duplicates.txt",
    			"C://Users/Daniel/eclipse-workspace/AlgorithmsSort/src/input/numbersNearlyOrdered1000.txt",
    			"C://Users/Daniel/eclipse-workspace/AlgorithmsSort/src/input/numbersReverse1000.txt",
    			"C://Users/Daniel/eclipse-workspace/AlgorithmsSort/src/input/numbersSorted1000.txt"
    			};
    for(String file : files) {
    	   ArrayList<Double> doubles = new ArrayList<>();
    	   try (BufferedReader br = new BufferedReader(new FileReader(file))) {
               String line = br.readLine();
               while (line != null) {
                   line = br.readLine();
                   if (line != null) doubles.add(Double.parseDouble(line));
               }

               double[] a = resetArray(doubles);
               //System.out.println("Selection Sort: ");
               //printArray(a);
               double startTime = System.nanoTime();
               SortComparison.selectionSort(a);
               double endTime = System.nanoTime();
               double duration = (endTime - startTime) / 1000000;
               //printArray(a);
               System.out.println("Selection Sort time for " + file.split("/")[file.split("/").length - 1] + ": " + duration + "ms");

               a = resetArray(doubles);
               //System.out.println("Insertion Sort: ");
               //printArray(a);
               startTime = System.nanoTime();
               SortComparison.insertionSort(a);
               endTime = System.nanoTime();
               duration = (endTime - startTime) / 1000000;
               //printArray(a);
               System.out.println("Insertion Sort time for " + file.split("/")[file.split("/").length - 1] + ": " + duration + "ms");

               a = resetArray(doubles);
               //System.out.println("MergeSort Iterative: ");
               //printArray(a);
               startTime = System.nanoTime();
               SortComparison.mergeSortIterative(a);
               endTime = System.nanoTime();
               duration = (endTime - startTime) / 1000000;
               //printArray(a);
               System.out.println("MergeSort Iterative time for " + file.split("/")[file.split("/").length - 1] + " was " + duration + "ms");


               a = resetArray(doubles);
               //System.out.println("MergeSort Recursive: ");
               //printArray(a);
               startTime = System.nanoTime();
               SortComparison.mergeSortRecursive(a);
               endTime = System.nanoTime();
               duration = (endTime - startTime) / 1000000;
               //printArray(a);
               System.out.println("MergeSort Recursive time for " + file.split("/")[file.split("/").length - 1] + ": " + duration + "ms");

               a = resetArray(doubles);
               //System.out.println("QuickSort: ");
               //printArray(a);
               startTime = System.nanoTime();
               SortComparison.quickSort(a);
               endTime = System.nanoTime();
               duration = (endTime - startTime) / 1000000;
               //printArray(a);
               System.out.println("QuickSort time for " + file.split("/")[file.split("/").length - 1] + ": " + duration + "ms");

           } catch (IOException e) {
               e.printStackTrace();
           }
       }
       }

	private static void printArray(double[] a) {
		for (double d : a) {
			System.out.print(d + ", ");
		}
		System.out.println();
	}

	private static double[] resetArray(ArrayList<Double> doubles) {
		double[] a;
		a = new double[doubles.size()];
		for (int j = 0; j < a.length; j++) {
			a[j] = doubles.get(j);
		}
		return a;
	} 
}