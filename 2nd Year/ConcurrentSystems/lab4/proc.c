// ONLY MODIFY CODE BELOW THE NEXT OCCURENCE OF THE FOLLOWING LINE !
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#include "types.h"
#include "defs.h"
#include <stdio.h>
#include <stdlib.h>
#include "proc.h"

#define NCPU 1

struct cpu cpus[NCPU];
int ncpu;

void printstate(enum procstate pstate)
{ // DO NOT MODIFY
    switch (pstate)
    {
    case UNUSED:
        printf("UNUSED");
        break;
    case EMBRYO:
        printf("EMBRYO");
        break;
    case SLEEPING:
        printf("SLEEPING");
        break;
    case RUNNABLE:
        printf("RUNNABLE");
        break;
    case RUNNING:
        printf("RUNNING");
        break;
    case ZOMBIE:
        printf("ZOMBIE");
        break;
    default:
        printf("????????");
    }
}

// Per-CPU process scheduler.
// Each CPU calls scheduler() after setting itself up.
// Scheduler never returns.  It loops, doing:
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.

// local to scheduler in xv6, but here we need them to persist outside,
// because while xv6 runs scheduler as a "coroutine" via swtch,
// here swtch is just a regular procedure call.
int pix;
int *prios;
int *p_order;
struct proc *p;
struct cpu *c = cpus;
int new_prio;
int saved;
int curr;
// +++++++ ONLY MODIFY BELOW THIS LINE ++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
void swap(int *xp, int *yp)
{
    int temp = *xp;
    *xp = *yp;
    *yp = temp;
}

// Function to perform Selection Sort
void selectionSort(int *arr, int n)
{
    int i, j, min_idx;

    // One by one move boundary of unsorted subarray
    for (i = 0; i < n - 1; i++)
    {

        // Find the minimum element in unsorted array
        min_idx = i;
        for (j = i + 1; j < n; j++)
            if (arr[j] < arr[min_idx])
                min_idx = j;

        // Swap the found minimum element
        // with the first element
        swap(&arr[min_idx], &arr[i]);
    }
}
void printArray(int *arr, int size)
{
    int i;
    for (i = 0; i < size; i++)
        printf("%d ", arr[i]);
    printf("\n");
}

void start()
{
    new_prio = 0;
    int filled = 0;
    prios = malloc(sizeof(int) * 5);
    p_order = malloc(sizeof(int) * 5);
    for (pix = 0; pix < NPROC; pix++)
    {
        p = &ptable.proc[pix];
        if (p->prio >= 9999)
        {
            break;
        }
        new_prio++;
        prios[pix] = p->prio;
    }

    selectionSort(prios, new_prio);
    for(int i = 0; i < new_prio; i++){
        p_order[i] = 0;
    }
    while (filled != 5){
        for (pix = 0; pix < NPROC; pix++) {
            p = &ptable.proc[pix];
            if (p->prio >= 9999)
            {
                break;
            }
            if(prios[filled] == p->prio){
                p_order[filled++] = pix;
            }
        }
    }
}

void scheduler(void)
{
    start();
    saved = 0;
    curr = 0;

    int runnableFound; // DO NOT MODIFY/DELETE
    c->proc = 0;

    runnableFound = 1; // force one pass over ptable
    while (runnableFound)
    { // DO NOT MODIFY
        // Enable interrupts on this processor.
        // sti();
        runnableFound = 0; // DO NOT MODIFY
        // Loop over process table looking for process to run.
        // acquire(&ptable.lock);
        for (int i = curr; i < new_prio; i++)
        {
            if(i > 0){
                if(prios[i-1] != prios[i]){
                    saved = i;
                    i = curr;

                }
            }
            pix = p_order[i];
            p = &ptable.proc[pix];

            if (p->state != RUNNABLE){
                curr = saved;
                continue;            
            }

            runnableFound = 1; // DO NOT MODIFY/DELETE/BYPASS

            // Switch to chosen process.  It is the process's job
            // to release ptable.lock and then reacquire it
            // before jumping back to us.
            c->proc = p;
            //switchuvm(p);
            p->state = RUNNING;

            swtch(p);
            // p->state should not be running on return here.
            //switchkvm();
            // Process is done running for now.
            // It should have changed its p->state before coming back.
            c->proc = 0;
        }
        // release(&ptable.lock);
    }
    printf("No RUNNABLE process!\n");
}
