import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.assertNull;

import org.junit.Test;
import org.junit.Ignore;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

//-------------------------------------------------------------------------
/**
 *  Test class for Doubly Linked List
 *
 *  @author  
 *  @version 13/10/16 18:15
 */
@RunWith(JUnit4.class)
public class DoublyLinkedListTest
{
    //~ Constructor ........................................................
    @Test
    public void testConstructor()
    {
      new DoublyLinkedList<Integer>();
    }

    //~ Public Methods ........................................................

    // ----------------------------------------------------------
    /**
     * Check if the insertBefore works
     */
    @Test
    public void testInsertBefore()
    {
        // test non-empty list
        DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
        testDLL.insertBefore(0,1);
        testDLL.insertBefore(1,2);
        testDLL.insertBefore(2,3);

        testDLL.insertBefore(0,4);
        assertEquals( "Checking insertBefore to a list containing 3 elements at position 0", "4,1,2,3", testDLL.toString() );
        testDLL.insertBefore(1,5);
        assertEquals( "Checking insertBefore to a list containing 4 elements at position 1", "4,5,1,2,3", testDLL.toString() );
        testDLL.insertBefore(2,6);       
        assertEquals( "Checking insertBefore to a list containing 5 elements at position 2", "4,5,6,1,2,3", testDLL.toString() );
        testDLL.insertBefore(-1,7);        
        assertEquals( "Checking insertBefore to a list containing 6 elements at position -1 - expected the element at the head of the list", "7,4,5,6,1,2,3", testDLL.toString() );
        testDLL.insertBefore(7,8);        
        assertEquals( "Checking insertBefore to a list containing 7 elemenets at position 8 - expected the element at the tail of the list", "7,4,5,6,1,2,3,8", testDLL.toString() );
        testDLL.insertBefore(700,9);        
        assertEquals( "Checking insertBefore to a list containing 8 elements at position 700 - expected the element at the tail of the list", "7,4,5,6,1,2,3,8,9", testDLL.toString() );

        // test empty list
        testDLL = new DoublyLinkedList<Integer>();
        testDLL.insertBefore(0,1);        
        assertEquals( "Checking insertBefore to an empty list at position 0 - expected the element at the head of the list", "1", testDLL.toString() );
        testDLL = new DoublyLinkedList<Integer>();
        testDLL.insertBefore(10,1);        
        assertEquals( "Checking insertBefore to an empty list at position 10 - expected the element at the head of the list", "1", testDLL.toString() );
        testDLL = new DoublyLinkedList<Integer>();
        testDLL.insertBefore(-10,1);        
        assertEquals( "Checking insertBefore to an empty list at position -10 - expected the element at the head of the list", "1", testDLL.toString() );
     }
    @Test
    public void testDeleteAt()
    {
        // test non-empty list
        DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
        testDLL.deleteAt(0);
        assertEquals( "test#1", "", testDLL.toString() );
        testDLL.insertBefore(0,1);
        testDLL.deleteAt(0);
        assertEquals( "test#2", "", testDLL.toString() );
        testDLL.insertBefore(0,1);
        testDLL.insertBefore(0,2);
        testDLL.insertBefore(0,3);
        testDLL.insertBefore(0,4);
        assertEquals( "test#3", "4,3,2,1", testDLL.toString() );
        testDLL.deleteAt(2);
        assertEquals( "test#4", "4,3,1", testDLL.toString());     
        testDLL.deleteAt(0);
        assertEquals( "test#5", "3,1", testDLL.toString());   
        testDLL.insertBefore(0,4);
        testDLL.insertBefore(0,5);
        testDLL.deleteAt(3);
        assertEquals( "test#6 (nothing)", "5,4,3", testDLL.toString());
        testDLL.deleteAt(-1);
        assertEquals( "test#7 (nothing)", "5,4,3", testDLL.toString());
        testDLL.deleteAt(6);
        assertEquals( "test#8 (nothing)", "5,4,3", testDLL.toString());
       
     } 
    @Test
    public void testGet()
    {
        // test non-empty list
        DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
        testDLL.insertBefore(0,1);
        testDLL.insertBefore(0,2);
        testDLL.insertBefore(0,3);
        testDLL.insertBefore(0,4);
        testDLL.get(2);
        assertEquals( "test#1", "2", testDLL.get(2).toString());     

       
     } 
    @Test
    public void testMakeUnique()
    {
        // test non-empty list
        DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
        testDLL.insertBefore(0,1);
        testDLL.insertBefore(0,2);
        testDLL.insertBefore(0,2);
        testDLL.insertBefore(0,3);
        testDLL.insertBefore(0,3);   
        testDLL.makeUnique();
        assertEquals( "test#1", "3,2,1", testDLL.toString()); 
        testDLL.insertBefore(0,1);
        testDLL.makeUnique();
        assertEquals( "test#1", "1,3,2", testDLL.toString());
    //    testDLL.insertBefore(0,1);
    //    testDLL.makeUnique();
        
     } 
    @Test
    public void testPush()
    {
        // test non-empty list
        DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
        testDLL.push(0);
        testDLL.push(1);
        testDLL.push(2);
        testDLL.push(3);
        assertEquals( "test#1", "3,2,1,0", testDLL.toString());     

        
     } 
    @Test
    public void testPop()
    {
        // test non-empty list
        DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
        testDLL.pop(); 
        assertEquals( "test#1", "", testDLL.toString());     
        testDLL.push(0);
        testDLL.pop(); 
        assertEquals( "test#2", "", testDLL.toString());  
        testDLL.push(1);
        testDLL.push(2);
        testDLL.push(3);
        testDLL.pop(); 
        assertEquals( "test#3", "2,1", testDLL.toString());     
        
     } 
    @Test
    public void enqueue()
    {
        // test non-empty list
        DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
        testDLL.enqueue(0);
        testDLL.enqueue(1);
        testDLL.enqueue(2);
        assertEquals( "test#3", "2,1,0", testDLL.toString()); 
     } 
    @Test   
    public void dequeue()
    {
        // test non-empty list
        DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
        testDLL.dequeue();   
        assertEquals("test#1", "", testDLL.toString());
        testDLL.enqueue(0);
        testDLL.dequeue();  
        assertEquals( "test#2", "", testDLL.toString());
        testDLL.enqueue(1);
        testDLL.enqueue(2);
        testDLL.dequeue();  
        assertEquals( "test#3", "2", testDLL.toString());
        
     } 
    @Test   
    public void hasOneNode()
    {
        // test non-empty list
        DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
        assertEquals( "test#1", false, testDLL.hasOneNode());
        testDLL.enqueue(1);
        assertEquals( "test#2", true, testDLL.hasOneNode());
        testDLL.enqueue(2);
        assertEquals( "test#3", false, testDLL.hasOneNode());
     } 
 
    

}
