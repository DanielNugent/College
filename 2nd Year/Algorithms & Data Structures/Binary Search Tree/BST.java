import java.util.NoSuchElementException;
import java.util.LinkedList;
import java.util.*;

public class BST<Key extends Comparable<Key>, Value> {
	private Node root; // root of BST

	/**
	 * Private node class.
	 */
	private class Node {
		private Key key; // sorted by key
		private Value val; // associated data
		private Node left, right; // left and right subtrees
		private int N; // number of nodes in subtree

		public Node(Key key, Value val, int N) {
			this.key = key;
			this.val = val;
			this.N = N;
		}
	}

	// is the symbol table empty?
	public boolean isEmpty() {
		return size() == 0;
	}

	// return number of key-value pairs in BST
	public int size() {
		return size(root);
	}

	// return number of key-value pairs in BST rooted at x
	private int size(Node x) {
		if (x == null)
			return 0;
		else
			return x.N;
	}

	/**
	 * Search BST for given key. Does there exist a key-value pair with given key?
	 *
	 * @param key
	 *            the search key
	 * @return true if key is found and false otherwise
	 */
	public boolean contains(Key key) {
		return get(key) != null;
	}

	/**
	 * Search BST for given key. What is the value associated with given key?
	 *
	 * @param key
	 *            the search key
	 * @return value associated with the given key if found, or null if no such key
	 *         exists.
	 */
	public Value get(Key key) {
		return get(root, key);
	}

	private Value get(Node x, Key key) {
		if (x == null)
			return null;
		int cmp = key.compareTo(x.key);
		if (cmp < 0)
			return get(x.left, key);
		else if (cmp > 0)
			return get(x.right, key);
		else
			return x.val;
	}

	/**
	 * Insert key-value pair into BST. If key already exists, update with new value.
	 *
	 * @param key
	 *            the key to insert
	 * @param val
	 *            the value associated with key
	 */
	public void put(Key key, Value val) {
		if (val == null) {
			delete(key);
			return;
		}
		root = put(root, key, val);
	}

	private Node put(Node x, Key key, Value val) {
		if (x == null)
			return new Node(key, val, 1);
		int cmp = key.compareTo(x.key);
		if (cmp < 0)
			x.left = put(x.left, key, val);
		else if (cmp > 0)
			x.right = put(x.right, key, val);
		else
		x.val = val;
		x.N = 1 + size(x.left) + size(x.right);
		return x;
	}

	/**
	 * Tree height.
	 *
	 * Asymptotic worst-case running time using Theta notation: Theta(N)
	 * Worst case where tree is all down the left or right (aka unbalanced)
	 * @return the number of links from the root to the deepest leaf.
	 *
	 *         Example 1: for an empty tree this should return -1. Example 2: for a
	 *         tree with only one node it should return 0. Example 3: for the
	 *         following tree it should return 2. B / \ A C \ D
	 */
	// Auxiliary method
	public int height() {
		Node tmp = root;
		if (isEmpty()) {
			return -1;
		} else {
			int h = height(tmp);
            return h-1;
		}
	}

	private int height(Node tmp) {
		int hL = 0;
		int hR = 0;
		if (tmp.left != null) {
			hL = height(tmp.left);
		}
		if (tmp.right != null) {
			hR = height(tmp.right);
		}
		if (hL > hR) {
			return (hL + 1);
		} else {
			return (hR + 1);
		}
	}

	/**
	 * Asymptotic worst-case running time using Theta notation: Theta(h) - where h = height of the tree
	 * The worst case is where it has to traverse to the height of the tree. This is a greedy algorithm 
	 * as it makes choices where to go next based on the computations.
	 * Median
	 * key. If the tree has N keys k1 < k2 < k3 < ... < kN, then their median key is
	 * the element at position (N+1)/2 (where "/" here is integer division)
	 *
	 * @return the median key, or null if the tree is empty.
	 */
	public Key median() {
		int median = (int)((size()-1)/2);
		if (median < 0 || median >= size()) return null;
		Node x = median(root, median);
		return x.key;
	}
	private Node median(Node node, int median) {
		if (node == null) return null;
		int tmp = size(node.left);
		if (tmp > median) return median(node.left, median);
		else if (tmp < median) return median(node.right, median-tmp-1);
		else return node;
	}
	
	/**
	 * Theta(N) time complexity. (N = #nodes). Visit each node once recursively.
	 * 
	 * Print all keys of the tree in a sequence, in-order. That is, for each node,
	 * the keys in the left subtree should appear before the key in the node. Also,
	 * for each node, the keys in the right subtree should appear before the key in
	 * the node. For each subtree, its keys should appear within a parenthesis.
	 *
	 * Example 1: Empty tree -- output: "()" Example 2: Tree containing only "A" --
	 * output: "(()A())" Example 3: Tree: B / \ A C \ D
	 *
	 * output: "((()A())B(()C(()D())))"
	 *
	 * output of example in the assignment:
	 * (((()A(()C()))E((()H(()M()))R()))S(()X()))
	 *
	 * @return a String with all keys in the tree, in order, parenthesized.
	 */
	public String printKeysInOrder() {
		if (isEmpty())
			return "()";
		else {
			String output = "(";
			return printKeysInOrder(root, output) + ")";
		}
	}

	private String printKeysInOrder(Node node, String output) {
		if (node.left != null) {
			output += "(";
			output = printKeysInOrder(node.left, output);
			output += ")";
		} else
			output += "()";
		output += node.key;
		if (node.right != null) {
			output += "(";
			output = printKeysInOrder(node.right, output);
			output += ")";
		} else
			output += "()";
		return output;

	}

	// (((()1(()2()))3((()4(()5()))6()))7(()8()))
	/**
	 * Pretty Printing the tree. Each node is on one line -- see assignment for
	 * details. Theta (N) time complexity. Visits each node once recursively. (similar to printKeysInOrder)
	 * 
	 * @return a multi-line string with the pretty ascii picture of the tree.
	 */
	public String prettyPrintKeys() {
		if (isEmpty()) {
			return "-null\n";
		} else
			return prettyPrint(root, "", "");
	}

	private String prettyPrint(Node node, String output, String prefix) {
		if (node == null)
			return output;
		else
			output += "-" + node.key + "\n";

		output = prettyPrint(node.left, output + prefix + " " + "|", prefix + " |");

		if (node.left == null)
			output += "-null\n";

		output = prettyPrint(node.right, output + prefix + "  ", prefix + "  ");

		if (node.right == null) {				
				output += "-null\n";
		}

		return output;
	}

	// Auxiliary methods - Adapted from V.Koutavas lecture slides. (from deleteMin and min to deleteMax and max)
	private Node deleteMax(Node node) {
		if (node.right == null)
			return node.left;
		node.right = deleteMax(node.right);
		node.N = 1 + size(node.left) + size(node.right);
		return node;
	}
	private Node max(Node node) {
		Node tmp = node;
		while (tmp.right != null) {
			tmp = tmp.right;
		}
		return tmp;
	}

	/**
	 * Deteles a key from a tree (if the key is in the tree). Note that this method
	 * works symmetrically from the Hibbard deletion: If the node to be deleted has
	 * two child nodes, then it needs to be replaced with its predecessor (not its
	 * successor) node.
	 * Worst case runtime should be Theta(h) where h is the height of the tree. 
	 * This is because it is a greedy algorithm which decides which path(left or right) to go down 
	 * based on the value of the node.
	 * @param key
	 *            the key to delete
	 */ 

	public void delete(Key key) {
		if (isEmpty()) {
			return;
		} else
			root = delete(root, key);
	}

	private Node delete(Node tmp, Key key) {
		if (tmp == null)
			return tmp;
		int cmp = key.compareTo(tmp.key);
		if (cmp < 0) {
			tmp.left = delete(tmp.left, key);
		} else if (cmp > 0) {
			tmp.right = delete(tmp.right, key);
		} else {
			if (tmp.left == null) {
				return tmp.right;
			}
			if (tmp.right == null) {
				return tmp.left;
			} 
				Node tmp2 = tmp;
				tmp = max(tmp2.left); //find predecessor
				tmp.left = deleteMax(tmp2.left);
				tmp.right = tmp2.right;
		}
		tmp.N = size(tmp.left) + size(tmp.right) + 1;
		return tmp;
	}
}