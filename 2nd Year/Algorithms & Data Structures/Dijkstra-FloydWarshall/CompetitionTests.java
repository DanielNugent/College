import org.junit.Test;

import static junit.framework.TestCase.assertEquals;

public class CompetitionTests {

    @Test
    public void testDijkstraConstructor() {
        int time = new CompetitionDijkstra("tinyEWD.txt", 55, 80, 55).timeRequiredforCompetition();
        assertEquals("TinyEWD Dijsktra", 34, time);
        time = new CompetitionDijkstra("tinyEWD.txt", 55, 80, 10).timeRequiredforCompetition();
        assertEquals("TinyEWD Dijsktra", -1, time);
        time = new CompetitionDijkstra("1000EWD.txt", 55, 80, 55).timeRequiredforCompetition();
        assertEquals("1000EWD Dijsktra", 26, time);
        time = new CompetitionDijkstra("1000EWD.txt", 10, 80, 40).timeRequiredforCompetition();
        assertEquals("1000EWD Dijsktra", -1, time);
        time = new CompetitionDijkstra("1000EWD.txt", 1000, 80, 60).timeRequiredforCompetition();
        assertEquals("1000EWD Dijsktra", -1, time);
        time = new CompetitionDijkstra("fake path", 55, 50, 10).timeRequiredforCompetition();
        assertEquals("Trying fake path - Dijsktra", -1, time);
        time = new CompetitionDijkstra(null, 55, 50, 10).timeRequiredforCompetition();
        assertEquals("Trying fake path - Dijsktra", -1, time);
        time = new CompetitionDijkstra("C:\\\\Users\\\\Daniel\\\\eclipse-workspace\\\\AlgorithmsPath\\\\src\\\\tinyEWD.txt", 55, 50, 10).timeRequiredforCompetition();
        assertEquals("Trying fake path - Dijsktra", -1, time);
        time = new CompetitionDijkstra("input-A.txt", 60,50,75).timeRequiredforCompetition();
        assertEquals("Input A", -1, time);
        time = new CompetitionDijkstra("input-J.txt", 60,50,75).timeRequiredforCompetition();
        assertEquals("Input J", -1, time);
    }

    @Test
    public void testFWConstructor() {
        int time = new CompetitionFloydWarshall("tinyEWD.txt", 55, 80, 55).timeRequiredforCompetition();
        assertEquals("TinyEWD FloydWarshall", 34, time);
        time = new CompetitionFloydWarshall("1000EWD.txt", 55, 80, 55).timeRequiredforCompetition();
        assertEquals("1000EWD FloydWarshall", 26, time);
        time = new CompetitionFloydWarshall("1000EWD.txt", 10, 80, 55).timeRequiredforCompetition();
        assertEquals("1000EWD FloydWarshall under 50", -1, time);
        time = new CompetitionFloydWarshall("1000EWD.txt", 110, 80, 55).timeRequiredforCompetition();
        assertEquals("1000EWD FloydWarshall over 100", -1, time);
        time = new CompetitionFloydWarshall("fake path", 55, 50, 10).timeRequiredforCompetition();
        assertEquals("Trying fake path - FloydWarshall", -1, time);
        time = new CompetitionFloydWarshall(null, 55, 50, 10).timeRequiredforCompetition();
        assertEquals("Trying fake path - FloydWarshall", -1, time);
        time = new CompetitionFloydWarshall("C:\\\\Users\\\\Daniel\\\\eclipse-workspace\\\\AlgorithmsPath\\\\src\\\\input\\tinyEWD.txt", 55, 50, 10).timeRequiredforCompetition();
        assertEquals("Trying fake path - FloydWarshall", -1, time);
        time = new CompetitionFloydWarshall("input-J.txt", 60,50,75).timeRequiredforCompetition();
        assertEquals("Input J", -1, time);
    }


    //TODO - more tests
    
}
/*

import org.junit.Test;

import static junit.framework.TestCase.assertEquals;

public class CompetitionTests {

    @Test
    public void testDijkstraConstructor() {
        int time = new CompetitionDijkstra("tinyEWD.txt", 55, 80, 55).timeRequiredforCompetition();
        assertEquals("TinyEWD Dijsktra", 34, time);
        time = new CompetitionDijkstra("tinyEWD.txt", 55, 80, 10).timeRequiredforCompetition();
        assertEquals("TinyEWD Dijsktra", -1, time);
        time = new CompetitionDijkstra("1000EWD.txt", 55, 80, 55).timeRequiredforCompetition();
        assertEquals("1000EWD Dijsktra", 26, time);
        time = new CompetitionDijkstra("1000EWD.txt", 10, 80, 40).timeRequiredforCompetition();
        assertEquals("1000EWD Dijsktra", -1, time);
        time = new CompetitionDijkstra("fake path", 55, 50, 10).timeRequiredforCompetition();
        assertEquals("Trying fake path - Dijsktra", -1, time);
        time = new CompetitionDijkstra(null, 55, 50, 10).timeRequiredforCompetition();
        assertEquals("Trying fake path - Dijsktra", -1, time);
        time = new CompetitionDijkstra("C:\\\\Users\\\\Daniel\\\\eclipse-workspace\\\\AlgorithmsPath\\\\src\\\\tinyEWD.txt", 55, 50, 10).timeRequiredforCompetition();
        assertEquals("Trying fake path - Dijsktra", -1, time);
        time = new CompetitionDijkstra("input-A.txt", 60,50,75).timeRequiredforCompetition();
        assertEquals("Input A", -1, time);
    }

    @Test
    public void testFWConstructor() {
        int time = new CompetitionFloydWarshall("tinyEWD.txt", 55, 80, 55).timeRequiredforCompetition();
        assertEquals("TinyEWD FloydWarshall", 34, time);
        time = new CompetitionFloydWarshall("1000EWD.txt", 55, 80, 55).timeRequiredforCompetition();
        assertEquals("1000EWD FloydWarshall", 26, time);
        time = new CompetitionFloydWarshall("1000EWD.txt", 10, 80, 55).timeRequiredforCompetition();
        assertEquals("1000EWD FloydWarshall", -1, time);
        time = new CompetitionFloydWarshall("fake path", 55, 50, 10).timeRequiredforCompetition();
        assertEquals("Trying fake path - FloydWarshall", -1, time);
        time = new CompetitionFloydWarshall(null, 55, 50, 10).timeRequiredforCompetition();
        assertEquals("Trying fake path - FloydWarshall", -1, time);
        time = new CompetitionFloydWarshall("C:\\\\Users\\\\Daniel\\\\eclipse-workspace\\\\AlgorithmsPath\\\\src\\\\tinyEWD.txt", 55, 50, 10).timeRequiredforCompetition();
        assertEquals("Trying fake path - FloydWarshall", -1, time);
    }


    //TODO - more tests
    
}
import org.junit.Test;

import static junit.framework.TestCase.assertEquals;

public class CompetitionTests {

    @Test
    public void testDijkstraConstructor() {
        int time = new CompetitionDijkstra("tinyEWD.txt", 55, 80, 55).timeRequiredforCompetition();
        assertEquals("TinyEWD Dijsktra", 34, time);
        time = new CompetitionDijkstra("C:\\Users\\Daniel\\eclipse-workspace\\AlgorithmsPath\\\\src\\input\\tinyEWD.txt", 55, 80, 10).timeRequiredforCompetition();
        assertEquals("TinyEWD Dijsktra", -1, time);
        time = new CompetitionDijkstra("1000EWD.txt", 55, 80, 55).timeRequiredforCompetition();
        assertEquals("1000EWD Dijsktra", 26, time);
        time = new CompetitionDijkstra("1000EWD.txt", 10, 80, 40).timeRequiredforCompetition();
        assertEquals("1000EWD Dijsktra", -1, time);
        time = new CompetitionDijkstra("fake path", 55, 50, 10).timeRequiredforCompetition();
        assertEquals("Trying fake path - Dijsktra", -1, time);
        time = new CompetitionDijkstra(null, 55, 50, 10).timeRequiredforCompetition();
        assertEquals("Trying fake path - Dijsktra", -1, time);
        time = new CompetitionDijkstra("C:\\\\Users\\\\Daniel\\\\eclipse-workspace\\\\AlgorithmsPath\\\\src\\\\tinyEWD.txt", 55, 50, 10).timeRequiredforCompetition();
        assertEquals("Trying fake path - Dijsktra", -1, time);
        time = new CompetitionDijkstra("input-A.txt", 60,50,75).timeRequiredforCompetition();
        assertEquals("Input A", -1, time);
        time = new CompetitionDijkstra("input-J.txt", 60,50,75).timeRequiredforCompetition();
        assertEquals("Input J", -1, time);
    }

    @Test
    public void testFWConstructor() {
        int time = new CompetitionFloydWarshall("tinyEWD.txt", 55, 80, 55).timeRequiredforCompetition();
        assertEquals("TinyEWD FloydWarshall", 34, time);
        time = new CompetitionFloydWarshall("1000EWD.txt", 55, 80, 55).timeRequiredforCompetition();
        assertEquals("1000EWD FloydWarshall", 26, time);
        time = new CompetitionFloydWarshall("1000EWD.txt", 10, 80, 55).timeRequiredforCompetition();
        assertEquals("1000EWD FloydWarshall", -1, time);
        time = new CompetitionFloydWarshall("fake path", 55, 50, 10).timeRequiredforCompetition();
        assertEquals("Trying fake path - FloydWarshall", -1, time);
        time = new CompetitionFloydWarshall(null, 55, 50, 10).timeRequiredforCompetition();
        assertEquals("Trying fake path - FloydWarshall", -1, time);
        time = new CompetitionFloydWarshall("C:\\\\Users\\\\Daniel\\\\eclipse-workspace\\\\AlgorithmsPath\\\\src\\\\input\\tinyEWD.txt", 55, 50, 10).timeRequiredforCompetition();
        assertEquals("Trying fake path - FloydWarshall", -1, time);
    }


    //TODO - more tests
    
}
 */ 
