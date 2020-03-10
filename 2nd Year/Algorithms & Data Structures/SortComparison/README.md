# Implementation of various common sorting algorithms comparing their speeds
Results

                    | Insertion | Selection | Merge Rec | Merge It | Quicksort |
10 random           |  0.0049ms |  0.8162ms | 0.0122ms  | 0.0452ms | 0.0088ms  |
100 random          |  0.046ms  |  0.0795ms | 0.0559ms  | 0.039ms  | 0.0413ms  | 
1000 random         |  1.9078ms |  5.6079ms | 0.6218ms  | 0.7361ms | 0.7039ms  |
1000 few unique     |  4.5196ms |  0.4423ms | 0.1843ms  | 0.128ms  | 0.1171ms  |   
1000 nearly ordered |  0.0255ms |  0.307ms  | 0.1498ms  | 0.0685ms | 0.0876ms  |
1000 reverse order  |  0.3159ms |  0.4091ms | 0.1186ms  | 0.0585ms | 0.5098ms  |
1000 sorted         |  0.0022ms |  0.3425ms | 0.1332ms  | 0.0569ms | 0.5553ms  |
