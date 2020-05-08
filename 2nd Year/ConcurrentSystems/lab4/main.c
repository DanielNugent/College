#include "types.h"
#include "defs.h"
#include "proc.h"
#include <stdio.h>
#include <string.h>

void initptable () {
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    p->state = UNUSED;
    p->pid  = 0;
    p->name[0] = 0;
    p->prio = 9999;
  }
}

int readproc() { // returns 0 if not a proc, 1 otherwise
  int l_p; // ptable index
  int l_state;        // Process state
  char l_name[17];               // Process name (debugging)
  uint l_prio;                     // Process priority
  char stuff[6];

  int rc;
  struct proc *p;
  int prc;

  l_p=999; l_state=999; l_prio=999;

#define EXPECTED 5
// PROC p state name prio
  rc = scanf( "%s %u %u %s %u"
    , stuff, &l_p, &l_state, l_name, &l_prio );
  // printf("rc=%d, stuff=%s\n",rc,stuff);
  if(rc==EXPECTED && strcmp(stuff,"PROC")==0){
    prc=1;
    printf( "PROCESS %d ", l_p );
    printstate(l_state);
    printf( " '%s' prio: %u\n", l_name, l_prio);
    p = &ptable.proc[l_p]; p->pid  = l_p; // VERY IMPORTANT!!
    p->state = l_state;
    strcpy(p->name,l_name);
    p->prio  = l_prio;
  } else {
    if(rc>=0) {printf("Expected %d items, found %d\n", EXPECTED, rc );}
    prc=0;
  }
  return prc;
}

void loadtables() {

  scanf("%u",&swtchLimit);
  while(readproc()){
    readactions();
  }
}

int main (int argc, const char * argv[]) {

  printf("\n\tWelcome to the xv6 Scheduler Simulator!\n\n");
  initptable();
  initpactions();
  loadtables();
  scheduler();
  return 0;

}
