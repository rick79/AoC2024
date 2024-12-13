# Advent of Code 2024
Trying to learn Julia this year.
### Day 1
Staring with two easy problems. Both part one and part two were solved in one line each after the input was parsed. Learned about broadcasting and working with arrays in Julia. 
#### Part one
Given two lists, sort them and calculate and sum pairwise distance between the lists.
```
BenchmarkTools.Trial: 10000 samples with 1 evaluation.
 Range (min … max):   63.708 μs …   2.271 s  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):      84.875 μs              ┊ GC (median):    0.00%
 Time  (mean ± σ):   316.840 μs ± 22.705 ms  ┊ GC (mean ± σ):  0.86% ± 2.15%

          ▃▄▄▅▆███▇▆▄▂                                          
  ▁▂▂▃▃▅▅▇██████████████▆▅▅▄▃▂▃▂▂▂▂▂▂▂▂▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ ▃
  63.7 μs         Histogram: frequency by time          148 μs <

 Memory estimate: 41.09 KiB, allocs estimate: 30.
```
#### Part two
Given two lists, multiply the numbers from the first list by the number of times they appear in the second list and sum these values.
```
BenchmarkTools.Trial: 7221 samples with 1 evaluation.
 Range (min … max):  295.084 μs …    9.713 s  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     317.166 μs               ┊ GC (median):    0.00%
 Time  (mean ± σ):     1.688 ms ± 114.304 ms  ┊ GC (mean ± σ):  0.61% ± 5.93%

   ▃▇█▇▇▆▅▄▄▃▃▂▂▁▁                                              ▂
  ███████████████████▇▇▆▇▆▅▆▆▇▅▆▇▆▆▅▆▅▁▅▅▃▃▅▃▃▅▃▁▁▁▃▁▄▁▃▃▁▁▁▁▁▅ █
  295 μs        Histogram: log(frequency) by time        602 μs <

 Memory estimate: 262.32 KiB, allocs estimate: 4052.
```

### Day 2
Another day with simple problems. Learned about constructing arrays with [x for x in y]. I foresee that my code will be less readable from now on. 
#### Part one
Given a list with number sequences, check if a sequence of numbers is in either increasing och decreasing order. Adjecent numbers can differ by [1-3]. Find the number of sequences that are in order.
```
BenchmarkTools.Trial: 7982 samples with 1 evaluation.
 Range (min … max):  108.458 μs …   5.486 s  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     125.750 μs              ┊ GC (median):    0.00%
 Time  (mean ± σ):   830.340 μs ± 61.407 ms  ┊ GC (mean ± σ):  0.72% ± 5.08%

    ▁▆█▅▃                                                       
  ▂▃██████▆▅▄▃▃▃▃▃▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▁▂▁▂▁▁▂▂▂▁▂▁▂▁▂ ▃
  108 μs          Histogram: frequency by time          302 μs <

 Memory estimate: 126.37 KiB, allocs estimate: 4013.
```
#### Part two
Given a list with number sequences, check if they are in order and if not if they can be made to be in order by removing exactly one number.
```
BenchmarkTools.Trial: 10000 samples with 1 evaluation.
 Range (min … max):  322.166 μs …  17.925 ms  ┊ GC (min … max):  0.00% …  0.00%
 Time  (median):     352.125 μs               ┊ GC (median):     0.00%
 Time  (mean ± σ):   444.207 μs ± 558.401 μs  ┊ GC (mean ± σ):  11.70% ± 12.53%

  █▆▄▃▂▁▁                                                       ▁
  █████████▇▇▇▆▇▆▅▃▅▄▅▅▃▅▄▄▄▃▄▃▁▅▁▄▃▁▁▄▄▁▁▃▃▁▁▁▁▁▃▁▁▄▁▆▆▇█▆▇▆▆▆ █
  322 μs        Histogram: log(frequency) by time       2.59 ms <

 Memory estimate: 862.93 KiB, allocs estimate: 24644.
```

### Day 3
This day was solved easily with regex. Learned how to use regex in Julia and how to work with matrices.
#### Part one
```
BenchmarkTools.Trial: 10000 samples with 1 evaluation.
 Range (min … max):  261.500 μs …  10.022 ms  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     277.542 μs               ┊ GC (median):    0.00%
 Time  (mean ± σ):   310.083 μs ± 304.762 μs  ┊ GC (mean ± σ):  4.25% ± 6.57%

   ▃▇█▃                                                          
  ▄█████▆▅▄▄▃▃▃▃▃▃▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▁▂▁▂▂ ▃
  262 μs           Histogram: frequency by time          509 μs <

 Memory estimate: 230.57 KiB, allocs estimate: 5206.
```
#### Part two
 ```
 BenchmarkTools.Trial: 10000 samples with 1 evaluation.
 Range (min … max):  228.250 μs …  15.183 ms  ┊ GC (min … max): 0.00% … 97.77%
 Time  (median):     243.417 μs               ┊ GC (median):    0.00%
 Time  (mean ± σ):   269.270 μs ± 276.992 μs  ┊ GC (mean ± σ):  2.69% ±  4.82%

   ▅██▃                                                          
  ▅█████▆▅▅▄▃▃▃▃▂▃▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▁▂▂▂▁▂▂ ▃
  228 μs           Histogram: frequency by time          478 μs <

 Memory estimate: 118.68 KiB, allocs estimate: 2182.
 ```

### Day 4
Day 4 was a xmas mess. Not that the problems were that hard, just that my solution was tedious. Solved both part one and part two by iterating through a matrix looking for patterns using conditional statements. Running time for part one is ~ 350 μs and for part two ~ 270 μs. Learned about the shorthand condition && dothisiftrue. My code will from now on be even less readable. 

### Day 5
Part one was about if a list of numbers fulfills a set of rules. Part two was about using the rulecheking to sort a list of numbers so that they adhere to the rules. Running time for part one was ~ 20 ms and for part two ~ 45 ms.Learned about anonymous functions as arguments. 

### Day 6
Part one was about walking about in a matrix turning 90 degrees to the right if you encounter an obstacle, solved by walking step by step. The solution could be sped up by determining how many steps you can take before you encounter a obstacle and mark all these as visited, something that I'd be able to do easily in R. Part two was a bit trickier, now we're looking to create an infinite loop in the path from part one by adding an additional obstacle. Solved by iterating through the path visited in part one checking what would happend if there was an obstacle added there. So basically brute-forcing the problem. Running time for part one was ~ 8 ms and for part two 0.53 s. Learned about using tuples and unpacking tuples returned from functions. Also learned that sometimes sets are much more efficient (went from ~ 18 s to ~ 0.53 s for part to by just switching an array to a set).

### Day 7
Another easy day. Build a tree based on a set of possible permutations of operators (+ and * for part one and +, * and concatenation for part two). Running time for part one was ~ 0.15 s and for part two ~ 4.7 s. Learned about using recursive functions and first class functions. 

### Day 8
Two straightforward problems. Given a set of points with given types on a map, calculate points extending on a line from each pair of points with the same type at the same intervals as the initial points. For part one only calculate one point in each direction and for part two calculate every point that falls within the map limits.  Running time for part one was ~ 320 μs and for part two ~ 460 μs. Learned about unpacking tuples in anonymous functions.
### Day 9
Todays problem was defragging a set consisting of numbers and empty spaces beteen numbers. In part one you just move the numbers at the back forwards to empty slots. In part two you move entire series of the same number at a time to the first empty slot of appropiate size. Running time for part one was ~ 48 ms and for part two ~ 0.8 s. Learned to not rely too much on recursion and iterating through arrays. And learned how to benchmark and time function calls.

### Day 10
Two easy problems. Given a height map and a set of starting positions map out paths that increases one level in elevation for each step. For part one count the number of reachable peak positions for each starting position and for part two how many unique paths there are between the starting positions and peak positions. Solved both pars using DFS. Running time for part one was 380 μs and for part two 370 μs. Didn't learn anything new today. =(

### Day 11
You start with a set of numbers. Each number will evolve according to a few rules, some of these rules will increase the number and others will split the number into two. You are required to iterate through these evolutions and then count the number of numbers you have at the end. 

#### Part one
For part one iterate 25 times. This was easy to brute force, but since the solution for part two works just as well for part one I used my latter solution here instead.

```
BenchmarkTools.Trial: 6923 samples with 1 evaluation.
 Range (min … max):  558.708 μs …  16.380 ms  ┊ GC (min … max): 0.00% …  0.00%
 Time  (median):     609.083 μs               ┊ GC (median):    0.00%
 Time  (mean ± σ):   716.147 μs ± 562.307 μs  ┊ GC (mean ± σ):  9.21% ± 14.15%

  ▆█▇▅▄▂▂▁▁                                                     ▂
  ████████████▇▇▆▃▄▅▄▄▃▃▁▁▄▁▁▁▁▁▁▁▁▃▁▁▁▁▁▁▁▁▁▄▆▅▇▇██████▇▇▇▆▅▆▆ █
  559 μs        Histogram: log(frequency) by time       2.21 ms <

 Memory estimate: 1.15 MiB, allocs estimate: 15100.
```
#### Part two
For part two iterate 75 times. Trying to brute force part two takes forever. Rewrote part one but with recursion and memoization.
```
BenchmarkTools.Trial: 199 samples with 1 evaluation.
 Range (min … max):  21.508 ms … 52.767 ms  ┊ GC (min … max):  0.00% … 58.30%
 Time  (median):     24.124 ms              ┊ GC (median):     7.19%
 Time  (mean ± σ):   25.059 ms ±  5.011 ms  ┊ GC (mean ± σ):  10.59% ± 10.03%

   ▁  █▅▃                                                      
  ▅█▄████▇▆▂▂▂▁▂▁▁▃▃▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▂▃ ▂
  21.5 ms         Histogram: frequency by time          52 ms <

 Memory estimate: 36.93 MiB, allocs estimate: 761936.
```

### Day 12
Given a garden with square plots represented by a matrix where the values denotes the type of plants. Plants of the same type adjecent to each other forms a region. A region can contain other regions. Calculate the cost for building fences around each region. In part one the cost is calculated by multiplying the region perimeter and area. In part two the cost is calculated by multiply the number of edges for each region with the area. 
#### Part one
Part one was easily solved with flood fill for calculating the area and at the same time for each filled plot counting the number of adjecent plots with another type of plant. Find the first non-processed region, calculate the cost, set the plots of the region as processed. Repeat until no more non-procesed plots exist. Learned how to use BenchmarkTools.
```
BenchmarkTools.Trial: 435 samples with 1 evaluation.
 Range (min … max):  10.801 ms … 46.986 ms  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     11.110 ms              ┊ GC (median):    0.00%
 Time  (mean ± σ):   11.498 ms ±  1.940 ms  ┊ GC (mean ± σ):  2.45% ± 5.13%

  ▅▆▇█▆▄▃             ▃▂▂                                      
  ███████▅▄▆▆▁▄▄▄▁▁███████▄▄▄▅▁▁▁▁▁▁▁▁▁▁▁▁▄▁▁▄▁▁▁▁▁▁▁▁▁▄▁▁▁▁▄ ▇
  10.8 ms      Histogram: log(frequency) by time      15.6 ms <

 Memory estimate: 5.65 MiB, allocs estimate: 28427.
 ```
#### Part two
Part two was trickier. Find the first non-processed region. Calculation the area as above. To calculate the number of edges begin from the top and iterate top down and left to right: if the plot has another type of plants than the previous plot and the plot above has another type of plats it has an edge; if it has the same type of plats as the previous, the plot above has another type of plant and the plot diagonally to the upper left side of the plot has the same type of plats it has an edge.  Rotate the garden by 90°. Repeat 4 times. Multiply the perimeter with the area. Getting the last part with the diagonally adjecent plot right took too much time. 
```
BenchmarkTools.Trial: 63 samples with 1 evaluation.
 Range (min … max):  72.346 ms … 95.831 ms  ┊ GC (min … max): 4.91% … 21.57%
 Time  (median):     78.718 ms              ┊ GC (median):    7.27%
 Time  (mean ± σ):   79.469 ms ±  4.053 ms  ┊ GC (mean ± σ):  8.04% ±  2.98%

               ▂ ▂▅▂█   ▅▂ ▂ ▂  ▅                              
  ▅▅▁▁▅█▅▁▁█▅█▁█▅█████▁███▅█▅█▅▅█▅▅▅▁▁▁▁▁▁▅▁▁▁▁▁▅▁▅▁▁▁▁▁▁▁▁▁▅ ▁
  72.3 ms         Histogram: frequency by time        91.4 ms <

 Memory estimate: 149.92 MiB, allocs estimate: 34205.
```

### Day 13
You're playing with a claw machine and can describe the claws motion as a system with two linear equations: ay<sub>1</sub> + by<sub>2</sub> = c<sub>1</sub> and ax<sub>1</sub>+bx<sub>2</sub>=c<sub>2</sub>. You move the claw by pushing one of two buttons (a and b) and it moves by y<sub>1</sub>, x<sub>1</sub> or y<sub>2</sub>, x<sub>2</sub> depending on which button you press. For each claw machine you have a target coordinate c<sub>1</sub>, c<sub>2</sub> that you want to reach. Solve for integer solutions.
#### Part one
I must admit that I didn't read the instructions that well before I started so I didn't see that the problem was a system of linear equations before I already had solved part one using loops. Firstly I rewrote the system as matrix A and the target point as a vector b and solved the system using `A\b`. Surprisingly this didn't work that well since there seems to be a very small error when doing this calculation for one of the machines in the test data. But since it is a very small system with only two unknowns it was easy to use substitution to solve it.
```
BenchmarkTools.Trial: 10000 samples with 1 evaluation.
 Range (min … max):   51.500 μs …   3.113 s  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):      75.188 μs              ┊ GC (median):    0.00%
 Time  (mean ± σ):   386.939 μs ± 31.130 ms  ┊ GC (mean ± σ):  0.00% ± 0.00%

                 ▁▂▃▄▃▂▁▁▂█▇▁                                   
  ▂▂▃▃▅▅▇▆▆▆▆▆▆▆▇█████████████▆▅▄▃▃▃▂▂▂▂▁▁▂▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ ▃
  51.5 μs         Histogram: frequency by time          122 μs <

 Memory estimate: 2.84 KiB, allocs estimate: 14.
```
#### Part two
In part two coordinates for the target points are increased by 10 000 000 000 000. Using loops for this is prohibitive, but luckily solving the linear system with these larger target coordinates works just the same as for the orginal target coordinates. The runtime for part one and part two should'nt differ, but I had to copy my array with claw machines when running the benchmark tests since I modify the target coordinates for part two.
```
BenchmarkTools.Trial: 4024 samples with 1 evaluation.
 Range (min … max):  145.292 μs …    6.500 s  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     163.416 μs               ┊ GC (median):    0.00%
 Time  (mean ± σ):     1.809 ms ± 102.463 ms  ┊ GC (mean ± σ):  0.33% ± 4.28%

  ▅█▆▅▃▂▁                                                       ▁
  █████████▇▇▆▆▆▃▄▅▅▆▄▅▄▅▁▃▃▄▁▅▃▅▃▅▅▃▄▁▁▄▁▁▃▁▅▃▄▄▃▁▁▄▃▃▃▁▃▁▃▃▃▃ █
  145 μs        Histogram: log(frequency) by time        777 μs <

 Memory estimate: 95.14 KiB, allocs estimate: 2204.
```

