import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

@RunWith(JUnit4.class)
public class BSTTest {

	@Test
	public void testConstructor() {
		new BST<Integer, Integer>();
	}
	
	@Test
	public void testContains() {
		BST<Integer, Integer> testBST = new BST<Integer, Integer>();
		testBST.put(1, 1);
		assertEquals("Get Test1", true, testBST.contains(1));
	}
	
	@Test
	public void testPut() {		
		BST<Integer, Integer> testBST = new BST<Integer, Integer>();
		testBST.put(1, null);
		testBST.put(1, 1);
		assertEquals("Get test 3", "1", Integer.toString(testBST.get(1)));
	}
	
	@Test
	public void testGet() {		
		BST<Integer, Integer> testBST = new BST<Integer, Integer>();
		assertEquals("Get Test1",  null, testBST.get(1));
		testBST.put(1, 1);
		assertEquals("Get Test1", "1", Integer.toString(testBST.get(1)));
		testBST.put(4, 4);
		testBST.put(3, 3);	
		testBST.put(2, 2);
		assertEquals("Get test 2", "2", Integer.toString(testBST.get(2)));
		testBST.put(6, 6);
		testBST.put(5, 5);
		assertEquals("Get test 3", "4", Integer.toString(testBST.get(4)));
	}

	@Test
	public void testHeight() {		
		BST<Integer, Integer> testBST = new BST<Integer, Integer>();
		assertEquals("Height Test1", "-1", Integer.toString(testBST.height()));
		testBST.put(1, 1);
		testBST.put(4, 4);
		testBST.put(3, 3);
		testBST.put(2, 2);
		testBST.put(6, 6);
		testBST.put(5, 5);
		assertEquals("Height Test2", "3", Integer.toString(testBST.height()));
	}

	@Test
	public void testMedian() {
		BST<Integer, Integer> testBST = new BST<Integer, Integer>();
		assertEquals("Median: Test1", null, testBST.median());
		testBST.put(5, 5);
		testBST.put(1, 1);
		testBST.put(4, 4);
		testBST.put(2, 2);
		testBST.put(3, 3);
		testBST.put(6, 6);
		assertEquals("Median: Test1", "3", testBST.median().toString());
		testBST.put(8, 8);
		testBST.put(9, 9);
		assertEquals("Median: Test3", "4", testBST.median().toString());
	}


	/**
	 * <p>
	 * Test {@link BST#prettyPrintKeys()}.
	 * </p>
	 */

	@Test
	public void testPrettyPrint() {
		BST<Integer, Integer> bst = new BST<Integer, Integer>();
		assertEquals("Checking pretty printing of empty tree", "-null\n", bst.prettyPrintKeys());

		               // -7
		               // |-3
		               // | |-1
		               // | | |-null
        bst.put(7, 7); // | | -2
		bst.put(8, 8); // | | |-null
		bst.put(3, 3); // | | -null
		bst.put(1, 1); // | -6
		bst.put(2, 2); // | |-4
		bst.put(6, 6); // | | |-null
		bst.put(4, 4); // | | -5
		bst.put(5, 5); // | | |-null
					   // | | -null
					   // | -null
					   // -8
					   // |-null
					    // -null

		String result = "-7\n" + " |-3\n" + " | |-1\n" + " | | |-null\n" + " | |  -2\n" + " | |   |-null\n"
				+ " | |    -null\n" + " |  -6\n" + " |   |-4\n" + " |   | |-null\n" + " |   |  -5\n"
				+ " |   |   |-null\n" + " |   |    -null\n" + " |    -null\n" + "  -8\n" + "   |-null\n"
				+ "    -null\n";
		assertEquals("Checking pretty printing of non-empty tree", result, bst.prettyPrintKeys());
	}

	/**
	 * <p>
	 * Test {@link BST#delete(Comparable)}.
	 * </p>
	 */
	@Test
	public void testDelete() {
		BST<Integer, Integer> bst = new BST<Integer, Integer>();
		bst.delete(1);
		assertEquals("Deleting from empty tree", "()", bst.printKeysInOrder());

		bst.put(7, 7); // _7_
		bst.put(8, 8); // / \
		bst.put(3, 3); // _3_ 8
		bst.put(1, 1); // / \
		bst.put(2, 2); // 1 6
		bst.put(6, 6); // \ /
		bst.put(4, 4); // 2 4
		bst.put(5, 5); // \
						// 5

		assertEquals("Checking order of constructed tree", "(((()1(()2()))3((()4(()5()))6()))7(()8()))",
				bst.printKeysInOrder());

		bst.delete(9);
		assertEquals("Deleting non-existent key", "(((()1(()2()))3((()4(()5()))6()))7(()8()))", bst.printKeysInOrder());

		bst.delete(8);
		assertEquals("Deleting leaf", "(((()1(()2()))3((()4(()5()))6()))7())", bst.printKeysInOrder());

		bst.delete(6);
		assertEquals("Deleting node with single child", "(((()1(()2()))3(()4(()5())))7())", bst.printKeysInOrder());

		bst.delete(3);
		assertEquals("Deleting node with two children", "(((()1())2(()4(()5())))7())", bst.printKeysInOrder());
	}

}
