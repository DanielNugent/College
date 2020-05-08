# Final assessment - will be uploaded after the deadline

This is the final assignment, worth 80% of the module marks, based on the attached archive FINAL-DISTR4.zip 

While an automated grading system will be used initially, your code will be looked at, particularly  in the event of it giving really wrong answers or code failing to compile. A failure of code to compile for any part below will cap the maximum mark for that component to 39% of its full mark.

It has three parts, each of which can be done and assessed independently of the others.

An exercise using Promela/SPIN to model a non-deterministic finite-state-automaton (NDFA)
An exercise to add dynamic priority (Linux-style) to the xv6 operating system.
An exercise to add more levels of indirection to file block access in xv6
Each is described in more detail below.

Submission Instructions
You need to submit the following files in a single zip or tar archive : final.pml, proc.h, proc.c, and fs.c., as well as a signed Assessment Declaration form.

## Part 1 (20% of overall)
Using Promela to model non-deterministic finite-state-automatons was described in Lecture 16. In the archive you will find the image for an example (EXAMPLE-NDFA.png) along with a PML file (ndfa4.pml) that implements that example. This has added printf statements that make its behaviour easier to observe. It has been setup to allow SPIN to search for all possible accepting sequences of exactly length 4.

To do this search you need to do the following step:  spin -run -E -c0 -e ndfa4.pml

This will generate a number of trail files, of which the nth can be viewed using spin -tn ndfa4.pml. So, for example, the 3rd trail file can be viewed using spin -t3 ndfa4.pml.

Task-1
Create a pml file called final.pml, that models the NDFA shown in FINAL-NDFA.png, and that also can search for accepting sequences of length less than or equal to 4.

Base your answer on ndfa4.pml, leaving lines 1..4 and 38..42 intact. 

For submission for Part-1 :  final.pml

Part 2 (30% of overall)
Practical 4 involved adding process priorities to a simulation of xv6. Here you are asked to extend this to the dynamic priority used in Linux, as described in Lecture 23.

The simulation has changed (from Practical 4) as follows

A global clock variable has been added (defs.h) and is used to track the time taken by processes in swtch().
The process state has a number of new components (see struct proc declaration in file proc.h).
The scheduler, in proc.c, does a regular pass over the processes to adjust their priorities, calling adjustpriority(p) for every process p.
## Task-2

You need to edit adjustpriority() in proc.c to implement the priority (dynprio) and base time quantum (quantum) calculations described in Lecture 23, Slides 14..17 and 19  (ignore slide 18 for this exercise). This may also require modifying the definition of  struct proc in proc.h by adding in extra fields to keep track of useful dynamic information. In particular this may help with the calculation of average sleeping time (avgsleep). Any extra fields added to struct proc need to be initialised by  function initproc(), also  in proc.c. Note that this has required small modifications to defs.h and main.c.

You should never modify the staticprio or lastrun components.

The current sleeping time for a process is the current time minus the last time that process was running, determined whenever adjustpriority is applied to that process. The average sleeping time for a process is taken as the average of all the sleeping times that are determined in this way. You will need to come up with a way to store historical information for the process to be able to compute the average.  

For submission for Part-2 :  proc.h proc.c

Part 3 (30% of overall)
The xv6 filesystem uses one level of indirection at most when looking up file block locations (see Fig 6-3 on p84 in the xv6 "book"). The Linux filesystem uses up to three levels of indirection (See slide 25 in Lecture 28). You are to provide xv6 with the ability to use three levels as well.

Both xv6 and Linux have 12 direct addresses, and use the 13th slot to point to an indirection table with 128 pointers.

## Task-3

You need to edit bmap() in file fs.c to add the extra levels of indirection. Look at the existing code carefully. In the original xv6 (and Linux), the disk block size and the size of each block containing indirection pointers is the same, and both can be found on disk and in memory, so one allocation call is used to get storage for them (balloc()).

In this simulator, we have shrunk things a bit so there are only 3 direct addresses, instead of 12, and each indirection table has only 4 entries, rather than 128. This means we cannot allocate such tables using balloc() as the size is different. Instead a new allocate function called indalloc() is used instead.

In order to test this properly, certain array sizes needed to be enlarged to allow a process that writes a lots of blocks - fixed in FINAL-DISTR4.zip.

A short guide to compiling/running the simulator is given below

For submission for Part-3 :  fs.c x

Compiling and running xv6
For the first time, and every time after modifying proc.h, do make clean and then make, from the command line.

At other times just make is enough

If you can't use make (e.g. on Windows), then do:

cc -c -o ide.o ide.c
cc -c -o console.o console.c
cc -c -o bio.o bio.c
cc -c -o fs.o fs.c
cc -c -o file.o file.c
cc -c -o swtch.o swtch.c
cc -c -o proc.o proc.c
cc -c -o main.o main.c
cc -o sim ide.o console.o bio.o fs.o file.o swtch.o proc.o main.o 

To run, just do  ./sim < file.dat

All scenarios are now in .dat files

near120.dat - scenario with process static priorities in range 118..121
frw.dat - scenario reading and writing files
fpanic.dat - scenario that fails with panic because file is too large. Will work fine when Task 3 is done.

