# Practical 4 - changing the **xv6** Scheduler.

This folder contains sources of a tool `sim` that simulates **xv6** from the perspective of the scheduler. That scheduler implements a round-robin policy.

Your task is to modify the scheduler to implement a simple priority policy.

## Task

### Key constraint
 
You are only allowed to modify file `proc.c`, and in there, only the code from the definition of `void scheduler(void)` downwards.

### Task Description

The simple priority policy is, whenever more than one process is `RUNNABLE`, then:

* select the one with the highest priority
* if there are several such processes of equal priority then choose them in round-robin order.

**Important** Priority numbers work as found in Unix: 
the lower the number, the higher the priority.

(see below for some discussion of expected behaviour)

## Submission

Your submission on Blackboard should consist **only** of the file `proc.c`.

## Using `sim`

### Compiling `sim`

To build/re-build the simulator, simply give the command `make` (or its Windows equivalent).

Alternatively, do the following:

```
cc -c -o swtch.o swtch.c 
cc -c -o proc.o proc.c
cc -c -o main.o main.c 
cc -o sim swtch.o proc.o main.o
```


### Running `sim`

The simulator requires a configuration file on standard input. These files have a format described in the file `Scheduler.md`, also in this folder.
One such file is `25CPU-equal.txt`.

To run the simulator with `25CPU-equal.txt` simply enter `./sim < 25CPU-equal.txt` at the command line. Its output is sent to standard output and so will appear in the terminal window.

The file `rr25CPU.log` contains a record of the outputs expected when using `25CPU-equal.txt` with the given round-robin scheduler.


## Behaviour Description

We provide a number of general scenarios, 
with a number of priority variants.
These are described in configuration files with names of the form:

```
<ScenarioName>-<PriorityVariant>.txt
```

### Priority Variants

We have four priority variants:

* `equal` - all processes have the same priorty (42).
* `rrprio` - all processes have their priority value the same as their process id. 
* `invprio` - all processes have their priority opposite to that in `rrprio`. 
* `grpprio` - process priorities are clumped together so every process has the same priority as at least one other process, and and also a different priority to some other process.

The outcome of the `equal` variant should be the same as that of the given round-robin scheduler. All other variants should result in a different execution sequence for all the process actions.

Files `rr<ScenarioName>.log` give the result of running any scenario
variant with the round-robin scheduler (that ignores priority).

### General Scenarios

* `25CPU` - five processes, each of which does five `CPU` actions, and then terminates.
* `RUNWAKE` - three processes: one mixes some `CPU` and `WAIT` actions, while the other two perform `CPU` and `WAKE` actions.
* `WAKEKILL` - three processes: one mixes some `CPU` and `WAIT` actions, another does `CPU` and `WAKE` actions, while the third performs `CPU` and `KILL`.


### Expected Behaviours (selected examples)

#### 25CPU-grpprio.txt

Here P1 and P3 have priority level 5 and P0, P2, and P4 have priority level 10, so P1 and P3 will run to completion before any of the others run at all.

They do so in round-robin order, so you will see `P1 P3 P1 P3 .... P1 P3`

The P0, P2 and P4 will also run in round-robin order, but the last process to run before this was P3, so we expect to see `P4 P0 P2 P4 P0 P2`  as P4 is next in round-robin order after P3.
