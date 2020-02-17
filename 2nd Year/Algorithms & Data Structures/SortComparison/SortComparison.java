import java.util.*;
import java.io.*;
// -------------------------------------------------------------------------

/**
 * @author Daniel Nugent
 * @version HT 2020
 */

class SortComparison {

	static double[] insertionSort(double a[]) {
		if (a != null) {
			int len = a.length;
			for (int i = 1; i < len; ++i) {
				double key = a[i];
				int j = i - 1;

				/*
				 * Move elements of arr[0..i-1], that are greater than key, to one position
				 * ahead of their current position
				 */
				while (j >= 0 && a[j] > key) {
					a[j + 1] = a[j];
					j = j - 1;
				}
				a[j + 1] = key;
			}
			return a;
		} else
			return a;

	}// end insertionsort

	static double[] selectionSort(double[] a) {
		if (a != null) {
			for (int i = 0; i < a.length - 1; i++) {
				int min = i;
				for (int j = i + 1; j < a.length; j++) {
					if (a[j] < a[min]) {
						min = j;
					}
				}
				swap(min, i, a);
			}
			return a;
		} else {
			return null;
		}
	}// end selectionsort

	static void swap(int i, int j, double a[]) {
		double temp = a[i];
		a[i] = a[j];
		a[j] = temp;
	}

	static double[] quickSort(double a[]) {
		if(a == null) return a;
		int lo = 0;
		int hi = a.length - 1;
		if (lo < hi) {
			int partition = partition(a, lo, hi);
			quickSort(a, lo, partition - 1);
			quickSort(a, partition + 1, hi);
		}
		return a;
	}

	static void quickSort(double a[], int lo, int hi) {
		if (lo < hi) {
			int partition = partition(a, lo, hi);
			quickSort(a, lo, partition - 1);
			quickSort(a, partition + 1, hi);
		}
	}

	static int partition(double a[], int lo, int hi) {
		double pivot = a[hi];
		int i = lo - 1;
		for (int j = lo; j <= hi - 1; j++) {
			if (a[j] < pivot) {
				i++;
				swap(i, j, a);
			}
		}
		swap(i + 1, hi, a);
		return i + 1;
	}

	static double[] mergeSortIterative(double[] a) {
        if (a != null) {
            int low = 0;
            int high = a.length - 1;

            double[] temp = Arrays.copyOf(a, a.length);

            for (int m = 1; m <= high - low; m = 2 * m) {
                for (int bottom = low; bottom < high; bottom += 2 * m) {
                    int mid = bottom + m - 1;
                    int top = bottom + 2 * m - 1;

                    merge(a, temp, bottom, mid, (top < high) ? top : high);
                }
            }
            return a;
        } else {
            return null;
        }
    }

    private static void merge(double[] a, double[] temp, int bottom, int mid, int top) {
        int k = bottom, i = bottom, j = mid + 1;

        while (i <= mid && j <= top) {
            if (a[i] < a[j]) {
                temp[k++] = a[i++];
            } else {
                temp[k++] = a[j++];
            }
        }

        while (i <= mid && i < a.length) {
            temp[k++] = a[i++];
        }

        for (i = bottom; i <= top; i++) {
            a[i] = temp[i];
        }
    }
    static double[] mergeSortRecursive(double[] a) {
        mergeSort(a);
        return a;
    }//end mergeSortRecursive

    private static void mergeSort(double[] a) {
        if (a != null) {
            if (a.length > 1) {
                int mid = a.length / 2;

                double[] leftArray = new double[mid];
                System.arraycopy(a, 0, leftArray, 0, mid);

                double[] rightArray = new double[a.length - mid];
                if (a.length - mid >= 0) System.arraycopy(a, mid, rightArray, 0, a.length - mid);
                mergeSort(leftArray);
                mergeSort(rightArray);

                int i = 0;
                int j = 0;
                int k = 0;

                while (i < leftArray.length && j < rightArray.length) {
                    if (leftArray[i] < rightArray[j]) {
                        a[k] = leftArray[i];
                        i++;
                    } else {
                        a[k] = rightArray[j];
                        j++;
                    }
                    k++;
                }

                while (i < leftArray.length) {
                    a[k] = leftArray[i];
                    i++;
                    k++;
                }

                while (j < rightArray.length) {
                    a[k] = rightArray[j];
                    j++;
                    k++;
                }
            }
        }
    }
}
// end class
