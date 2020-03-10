#define STONES 5
/* the success condition */
/*#define success (\
    ((frogs[1]==4) && \
 (frogs[2]==5) && \
 (frogs[3]==1) && \
 (frogs[4]==2)) ||\
  ((frogs[1]==5) && \ 
  (frogs[2]==4) && \
  (frogs[3]==1) && \
  (frogs[4]==2)) \
)*/

mtype frogsMoved[STONES];
mtype frogs[STONES]; //frogs[0] = EMPTY SPOT location, 
//frogs[1] and frogs[2] are right to left moving (location)
//and frogs[3] and frogs[4] are left to right moving (location)
// 3 
//ltl { []!success }

proctype moveLeft(byte at) {
end:do
	:: 	atomic {
			(at < STONES) && 
			(frogs[0] == at+1) -> 
			frogs[0] = at; 
            if
            ::(frogs[1] == at) -> 
            printf("FROG%d FROM %d TO %d\n", 1, frogs[1], at+1);
              frogs[1] = at+1;
              frogs[0] = at;     
            ::(frogs[2] == at) -> 
            printf("FROG%d FROM %d TO %d\n", 2, frogs[2], at+1);
              frogs[2] = at+1;
              frogs[0] = at; 
            fi
			at = at + 1;
            printf("EMPTY %d, FROG1@%d, FROG2@%d, FROG3@%d, FROG4@%d\n", frogs[0], frogs[1], frogs[2], frogs[3], frogs[4]);
		}
	:: atomic {
			(at < STONES-1) && 
	   		(frogs[0] != at+1) && 
			(frogs[0] == at+2) -> 
            if
            ::(frogs[1] == at) -> 
              printf("FROG%d FROM %d TO %d\n", 1, frogs[1], at+2);
              frogs[1] = at+2;
              frogs[0] = at; 
            ::(frogs[2] == at) -> 
            printf("FROG%d FROM %d TO %d\n", 2, frogs[2], at+2);
              frogs[2] = at+2;
              frogs[0] = at; 
            fi
			at = at + 2;
            printf("EMPTY %d, FROG1@%d, FROG2@%d, FROG3@%d, FROG4@%d\n", frogs[0], frogs[1], frogs[2], frogs[3], frogs[4]);
		}
	od
}


proctype moveRight(byte at) {
end:do
	:: atomic {
			(at > 1) && 
			(frogs[0] == at-1) -> 
        if
        ::(frogs[3] == at) -> 
         printf("FROG%d FROM %d TO %d\n", 3, frogs[3], at-1);
         frogs[3] = at-1;
         frogs[0] = at;   
        ::(frogs[4] == at) -> 
         printf("FROG%d FROM %d TO %d\n", 4, frogs[4], at-1);
         frogs[4] = at-1;
         frogs[0] = at; 
        fi
        at = at - 1;
        printf("EMPTY %d, FROG1@%d, FROG2@%d, FROG3@%d, FROG4@%d\n", frogs[0], frogs[1], frogs[2], frogs[3], frogs[4]);
		}
	:: atomic {
			(at > 2) && 
	   		(frogs[0] != at-1) && 
			(frogs[0] == at-2) -> 
		    if
        ::(frogs[3] == at) -> 
        printf("FROG%d FROM %d TO %d\n", 3, frogs[3], at-2);
        frogs[3] = at-2;
        frogs[0] = at; 
        ::(frogs[4] == at) -> 
        printf("FROG%d FROM %d TO %d\n", 4, frogs[4], at-2);
        frogs[4] = at-2;
        frogs[0] = at; 
        fi
		    at = at - 2;
        printf("EMPTY %d, FROG1@%d, FROG2@%d, FROG3@%d, FROG4@%d\n", frogs[0], frogs[1], frogs[2], frogs[3], frogs[4]);
		}
	od
}

init { 
atomic{
    frogs[0] = 3;
    frogs[1] = 1;
    frogs[2] = 2;
    frogs[3] = 4;
    frogs[4] = 5;
    frogsMoved[0] = 0;
    frogsMoved[1] = 0;
    frogsMoved[2] = 0;
    frogsMoved[3] = 0;
    frogsMoved[4] = 0;
  printf("EMPTY %d, FROG1@%d, FROG2@%d, FROG3@%d, FROG4@%d\n", frogs[0], frogs[1], frogs[2], frogs[3], frogs[4]);
}
  atomic{
      frogs[0] = 3;
      byte I = 0;
      printf("FROG1 (RIGHT) STARTS AT 1\n");
      printf("FROG2 (RIGHT) STARTS AT 2\n");
      printf("FROG3 (LEFT) STARTS AT 4\n");
      printf("FROG4 (LEFT) STARTS AT 5\n");
      do
      :: I == STONES/2 -> break;
   	  :: else -> 
         
         run moveLeft(I+1);
		     run moveRight(STONES-I);
         I++
        od
  }
}