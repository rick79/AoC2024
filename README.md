# Advent of Code 2024
Trying to learn Julia this year.
## Day 1: Historian Hysteria
Learned about broadcasting and working with arrays in Julia. 

## Day 2: Red-Nosed Reports
Learned about constructing arrays comprehensiouns ([x for x in y]). I foresee that my code will be less readable from now on. 

## Day 3: Mull It Over
Learned how to use regex in Julia and how to work with matrices.

## Day 4: Ceres Search
Learned about the shorthand condition && dothisiftrue. My code will from now on be even less readable. 

## Day 5: Print Queue
Learned about anonymous functions as arguments. 

## Day 6: Guard Gallivant
Learned about using tuples and unpacking tuples returned from functions. Also learned that sometimes sets are much more efficient (went from ~ 18 s to ~ 0.5 s for part to by just switching an array to a set).

## Day 7: Bridge Repair
Learned about using recursive functions, first class functions and the splat (`...`) operator. 

## Day 8: Resonant Collinearity
Learned about unpacking tuples in anonymous functions.






## Day 9: Disk Fragmenter
Todays problem was defragging a set consisting of numbers and empty spaces beteen numbers. Learned to not rely too much on recursion and iterating through arrays. And learned how to benchmark and time function calls.
### Part one
In part one you just move the numbers at the back forwards to empty slots.
```
BenchmarkTools.Trial: 109 samples with 1 evaluation.
 Range (min … max):  45.138 ms …  50.153 ms  ┊ GC (min … max): 0.00% … 7.38%
 Time  (median):     45.909 ms               ┊ GC (median):    0.00%
 Time  (mean ± σ):   46.036 ms ± 773.324 μs  ┊ GC (mean ± σ):  0.86% ± 1.34%

  ▃ ▂ █   ▂  ▂ ▂▂ ▂   ▂                                         
  █████▄▇█████▇████▅▅▅█▅▇▇▄▅▄▁▁▅▁▄▁▄▁▁▄▁▁▁▁▄▅▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▄ ▄
  45.1 ms         Histogram: frequency by time         48.9 ms <

 Memory estimate: 7.88 MiB, allocs estimate: 245509.
```
### Part two
In part two you move entire series of the same number at a time to the first empty slot of appropiate size.
```
BenchmarkTools.Trial: 7 samples with 1 evaluation.
 Range (min … max):  820.639 ms … 825.777 ms  ┊ GC (min … max): 0.55% … 0.73%
 Time  (median):     824.198 ms               ┊ GC (median):    0.72%
 Time  (mean ± σ):   823.908 ms ±   1.800 ms  ┊ GC (mean ± σ):  0.64% ± 0.21%

  █                       █        █        █           ██    █  
  █▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁██▁▁▁▁█ ▁
  821 ms           Histogram: frequency by time          826 ms <

 Memory estimate: 109.85 MiB, allocs estimate: 3598905.
```

## Day 10: Hoof It
Two easy problems. Given a height map and a set of starting positions map out paths that increases one level in elevation for each step. Didn't learn anything new today. =(
### Part one
For part one count the number of reachable peak positions for each starting position. Solved using DFS.
```
BenchmarkTools.Trial: 10000 samples with 1 evaluation.
 Range (min … max):  299.708 μs …  10.783 ms  ┊ GC (min … max): 0.00% … 66.79%
 Time  (median):     325.854 μs               ┊ GC (median):    0.00%
 Time  (mean ± σ):   377.106 μs ± 304.205 μs  ┊ GC (mean ± σ):  8.51% ± 13.18%

  ▆█▆▅▄▃▂▂▁▁                                                    ▂
  ████████████▇▇▇▅▅▅▁▄▃▃▁▁▃▃▃▃▁▃▁▁▃▁▁▁▁▁▃▆▆▆███▇▇▆▆▄▄▄▃▄▅▆▆▆███ █
  300 μs        Histogram: log(frequency) by time       1.22 ms <

 Memory estimate: 867.20 KiB, allocs estimate: 8993.
```
### Part two
For part two find how many unique paths there are between the starting positions and peak positions. Solved using DFS.
```
BenchmarkTools.Trial: 10000 samples with 1 evaluation.
 Range (min … max):  274.583 μs …  10.199 ms  ┊ GC (min … max): 0.00% … 96.33%
 Time  (median):     297.417 μs               ┊ GC (median):    0.00%
 Time  (mean ± σ):   346.543 μs ± 273.812 μs  ┊ GC (mean ± σ):  8.95% ± 13.31%

  ▇█▆▅▄▂▂▁▁                                                     ▂
  ███████████▇▇▇▆▅▅▅▄▃▁▁▃▃▁▃▄▁▁▃▁▁▁▁▁▁▁▁▃▁▃▁▁▄▆▇▇██▇▇▆▆▅▃▆▆▇███ █
  275 μs        Histogram: log(frequency) by time       1.17 ms <

 Memory estimate: 829.38 KiB, allocs estimate: 8067.
```

## Day 11: Plutonian Pebbles
You start with a set of numbers. Each number will evolve according to a few rules, some of these rules will increase the number and others will split the number into two. You are required to iterate through these evolutions and then count the number of numbers you have at the end. 

### Part one
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
### Part two
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

## Day 12: Garden Groups
Given a garden with square plots represented by a matrix where the values denotes the type of plants. Plants of the same type adjecent to each other forms a region. A region can contain other regions. Calculate the cost for building fences around each region. In part one the cost is calculated by multiplying the region perimeter and area. In part two the cost is calculated by multiply the number of edges for each region with the area. 
### Part one
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
### Part two
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

## Day 13: Claw Contraption
You're playing with a claw machine and can describe the claws motion as a system with two linear equations: ay<sub>1</sub> + by<sub>2</sub> = c<sub>1</sub> and ax<sub>1</sub>+bx<sub>2</sub>=c<sub>2</sub>. You move the claw by pushing one of two buttons (a and b) and it moves by y<sub>1</sub>, x<sub>1</sub> or y<sub>2</sub>, x<sub>2</sub> depending on which button you press. For each claw machine you have a target coordinate c<sub>1</sub>, c<sub>2</sub> that you want to reach. Solve for integer solutions.
### Part one
I must admit that I didn't read the instructions that well before I started so I didn't see that the problem was a system of linear equations before I already had solved part one using loops. Firstly I rewrote the system as matrix A and the target point as a vector b and solved the system using `A\b´. Surprisingly this didn't work that well since there seems to be a very small error when doing this calculation for one of the machines in the test data. But since it is a very small system with only two unknowns it was easy to use substitution to solve it.
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
### Part two
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

## Day 14: Restroom Redoubt
You are in a bathroom at Easter Bunny HQ that is being patrolled by a swarm of robots that each have a position and velocity. You need to find out where the robots will be in the future. You are given the rooms height and width and a list of robots (with y, x, Δy/s, and Δx/s). Simulate where the robots will be after a given amount of time has passed. Robots that move outside the confines of the room teleport to the other side of the room.
### Part one
The first part was pretty straigt forward. Simulate where the robots are after 100 seconds and calculate a score based on the multiple of robots in each quadrant of the room. Robots that are in the middle horizontal and vertical lines does not count. Just increase each robots position with the velocity * number of seconds (100). Take the y component modulo the height and the x component modulo the width to account for robots moving of the right and bottom edges. If a robot has a negative position move it to the other side of the room to account for robots moving of the top and left edges. Calulate the score by multiplying the number of robots in each quadrant of the room discounting robots that are on either of the middle lines.
```
BenchmarkTools.Trial: 7911 samples with 1 evaluation.
 Range (min … max):  173.000 μs …   3.214 s  ┊ GC (min … max): 0.00% …  0.00%
 Time  (median):     196.375 μs              ┊ GC (median):    0.00%
 Time  (mean ± σ):   628.057 μs ± 36.133 ms  ┊ GC (mean ± σ):  3.05% ± 11.07%

  ▇█▆▅▃▂▁                                                      ▁
  █████████▇▇▆▆▆▃▄▁▄▁▁▄▁▁▁▁▅▄▅▃▃▄▁▁▁▄▆▃▄▄▃▁▁▃▄▄▅▄▅▅▆▄▅▅▄▄▄▄▄▄▃ █
  173 μs        Histogram: log(frequency) by time      1.08 ms <

 Memory estimate: 320.10 KiB, allocs estimate: 1948.
```
### Part two
Part two was trickier. Now you want to know how many seconds have to pass for the majority of the robots to form a christmas tree. Without knowing how they form the tree (large tree, small tree, edges of a tree, filled tree, etc). My first solution was to output the first 10 000 iterations to a file and manually inspect the contents for something that looked like a tree. It worked. Knowing how the tree looked my next solution was to calcuate an adjecency score for a a given state where each robot adds 0 - 4 to the score depending on how many directions there are another robot in. Then I looped through the first 10 000 iterations looking for the highest adjecency score. You could probably take a sample and calculate a mean adjecency score and look for scores that are significantly larger than this to not have to loop through so many iterations.

Looking at how others have solved part two many seems to have assumed that either each robots will have a unique position or that several robots will line up vertically or horizontally when the form the tree. Both ways work, but they are hail maries when it comes to reasoning. Some have used the Chinese Remainder-Theorem to calculate the number of seconds after finding that the robots repeat their y and x positions every 101 respective 103 seconds. This is a much nicer solution but you still need to find these intervalls. Others have calculated a mean standard deviation for the robots positions and used this to find a time where the deviation differs a lot.
```
1111111111111111111111111111111
1                             1
1                             1
1                             1
1                             1
1              1              1
1             111             1
1            11111            1
1           1111111           1
1          111111111          1
1            11111            1
1           1111111           1
1          111111111          1
1         11111111111         1
1        1111111111111        1
1          111111111          1
1         11111111111         1
1        1111111111111        1
1       111111111111111       1
1      11111111111111111      1
1        1111111111111        1
1       111111111111111       1
1      11111111111111111      1
1     1111111111111111111     1
1    111111111111111111111    1
1             111             1
1             111             1
1             111             1
1                             1
1                             1
1                             1
1                             1
1111111111111111111111111111111
```
```
BenchmarkTools.Trial: 31 samples with 1 evaluation.
 Range (min … max):  153.484 ms … 174.081 ms  ┊ GC (min … max): 26.01% … 31.56%
 Time  (median):     159.929 ms               ┊ GC (median):    28.26%
 Time  (mean ± σ):   161.631 ms ±   4.902 ms  ┊ GC (mean ± σ):  28.36% ±  1.59%

              ▄▁   █      ▁▁                                     
  ▆▁▁▁▁▁▆▁▁▁▆▆██▆▁▁█▆▆▁▆▁▁██▆▁▁▆▆▁▁▁▁▆▆▁▁▁▆▁▆▁▁▁▁▆▁▁▁▁▁▁▁▁▁▁▁▆▆ ▁
  153 ms           Histogram: frequency by time          174 ms <

 Memory estimate: 795.53 MiB, allocs estimate: 31931.
```

## Day 15: Warehouse Woes
Todays problems should be called the Adventures of Lolo! You start in a warehouse consisting of walls (`#`) and crates (`O` for part one, `[]` for part two) and are given a set of instructions (move up, down, left or right). When you move into a crate you push it. If several crates are lined up you push all of them. You can not move or push a crate into a wall.
### Part one
My solution for part one was to go through each instruction. For each instruction checking if the space indicated by the instruction is empty, and if it is a crate if the next space in line etc, stoping if encountering a wall. If there is at least one emtpy space in the line of movement push the current position into a que and repeat until the que is empty: pop the last item from the que; if the next space in line is empty, move there; if the next space is a crate push the current position and the crates position to the que.
```
BenchmarkTools.Trial: 6095 samples with 1 evaluation.
 Range (min … max):  620.667 μs …  14.201 ms  ┊ GC (min … max):  0.00% …  0.00%
 Time  (median):     665.959 μs               ┊ GC (median):     0.00%
 Time  (mean ± σ):   811.491 μs ± 505.422 μs  ┊ GC (mean ± σ):  14.18% ± 18.35%

  ▅█▇▆▅▄▃▂▂▁▁ ▁                         ▂▂▂▂▁   ▁▂▂▂▁           ▂
  █████████████▇▇▆▇▆▆▃▅▃▅▅▄▃▄▁▁▁▁▁▁▁▁▅▆████████████████▇▇▆▇▇▆▅▆ █
  621 μs        Histogram: log(frequency) by time       1.69 ms <

 Memory estimate: 3.19 MiB, allocs estimate: 34552.
```
### Part two
In part to the warehouse gets twice as wide where walls (`#`) becomes (`##`) and crates (`O`) becomes (`[]`). The solution from part one was easily modified to accomodate for part two. When checking if there is an empty space in the line of movement when moving up or down also consider if the next space is a `[` or a `]`, instead of just checking one line from the current position also check from the positions of `[` and `]`. My original check from part one used a que, for part 2 I changed this to a recursive function that continues checking in a line if it encounters a small crate (`O`) or branches out if it encounters a large crate (either `[]`). When pushing crates crates left or right, just use the same as for part one. When pushing up or down and encounter a large crate (`[]`) push the current position and each of the large crates positions to the que.
```
BenchmarkTools.Trial: 5100 samples with 1 evaluation.
 Range (min … max):  730.083 μs …  17.408 ms  ┊ GC (min … max):  0.00% …  0.00%
 Time  (median):     806.417 μs               ┊ GC (median):     0.00%
 Time  (mean ± σ):   970.988 μs ± 617.221 μs  ┊ GC (mean ± σ):  12.33% ± 16.81%

   ▂██▆▅▄▃▂▂▁ ▁▁                   ▂▂▂▂▁▁  ▁▂▂▂▂▁               ▂
  █████████████████▇▅▆▃▅▅▄▄▃▁▃▃▆▆▆███████▇▇████████▆▆▆▅▆▆▅▃▅▆▅▃ █
  730 μs        Histogram: log(frequency) by time       1.95 ms <

 Memory estimate: 3.40 MiB, allocs estimate: 35949.
```

## Day 16: Reindeer Maze
Another grid problem! You have a maze and want to find the shortest path from the start to the exit. Taking one step costs 1, turning 90° costs 1000. This makes the maze a weighted graph.
### Part one
I haven't done Dijkstra's algorithm in Julia yet! I implemented an more or less textbook version of Dijkstras and a weight function that takes the direction you're facing and the direction you want to move in and returns the cost (1 or 1001). Could probably have optimised it by not storing the distance to every node. Since each node is identified by it's position in the grid and your facing we have to check the shortest distance to the end position coming from every direction.
```
BenchmarkTools.Trial: 10 samples with 1 evaluation.
 Range (min … max):  512.559 ms … 576.512 ms  ┊ GC (min … max): 24.28% … 31.23%
 Time  (median):     520.959 ms               ┊ GC (median):    25.51%
 Time  (mean ± σ):   536.426 ms ±  26.840 ms  ┊ GC (mean ± σ):  26.97% ±  3.06%

  ▁█▁ ▁      ▁                              ▁     ▁      ▁    ▁  
  ███▁█▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁█▁▁▁▁▁▁█▁▁▁▁█ ▁
  513 ms           Histogram: frequency by time          577 ms <

 Memory estimate: 3.11 GiB, allocs estimate: 1540987.
```
### Part two
In part two you want to find all positions in the grid that lies on a shortest path (there can be several shortest paths with the same length). I kept the path leading up to each position and appended it along with the path distance to a list of paths when reaching the end position. I then constructed a set of the positions with the shortest path distance and counted the number of elements in the set.
```
BenchmarkTools.Trial: 9 samples with 1 evaluation.
 Range (min … max):  553.057 ms … 608.418 ms  ┊ GC (min … max): 29.60% … 35.53%
 Time  (median):     591.316 ms               ┊ GC (median):    31.41%
 Time  (mean ± σ):   586.232 ms ±  18.936 ms  ┊ GC (mean ± σ):  32.33% ±  2.22%

  █             █      █          █         █    █ █         ██  
  █▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁█▁▁▁▁█▁█▁▁▁▁▁▁▁▁▁██ ▁
  553 ms           Histogram: frequency by time          608 ms <

 Memory estimate: 3.11 GiB, allocs estimate: 1541011.
```

## Day 17: Chronospatial Computer
This day's problem is about debugging/simulating a 3 bit computer. The computer has 3 registers that can contain arbitrarily large numbers, a memory that stores a sequence of 3 bit numbers, and an output buffer. The computer has 8 instructions that are identified by a 3 bit number opcode and has a 3 bit number operand. The instructions either operate on the registers and/or operand, jumps to a new location in memory and continue executing the program from there, or outputs a register to the output buffer. When running a program the computer reads two three bit numbers from memory, the first denoting the instruction and the second the operand, and executes the instruction. You are given an initial state for the registers and the program stored in the memory.
A keyword that's worth noting is bit, it'll become important later.
### Part one
In part one you are asked to run the program in memory by simulating the computer. I implemented the instructions as anonymous functions with one parameter (the operand) in a dictionary with the instruction opcodes as keys. Then I just iterated through the program calling the instruction function using the opcode and passing the operand as parameter. The anonymous functions then operated on the three registers and the output buffer. By running the program you build up a sequence of numbers in the output buffer that is the output of the program. This was one of the fastest problems to implement for me this year, but it took a turn for the worse in part two...
```
BenchmarkTools.Trial: 10000 samples with 1 evaluation.
 Range (min … max):   62.625 μs …   2.870 s  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):      83.709 μs              ┊ GC (median):    0.00%
 Time  (mean ± σ):   386.744 μs ± 28.696 ms  ┊ GC (mean ± σ):  0.00% ± 0.00%

    ▅▆█▁                                                        
  ▃█████▆▄▃▃▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▁▂▂▂▂▂▁▁▁▂▂▁▂▂▂▁▁▂▁▁▂▁▂▂ ▃
  62.6 μs         Histogram: frequency by time          377 μs <

 Memory estimate: 3.09 KiB, allocs estimate: 104.
 ```
 ### Part two
 In part two the purpose of the program is to replicate itself. So instead of the output from part one you need to find an initial state for one of the registers so that the program (the same program as in part one) output itself to the output buffer. Honestly it took me quite a while to figure this one out. Bruteforcing the problen is out of question, a quick inspection of the output with various starting states showed that the register needed to be set to a value in the range of 8<sup>15</sup> - 8<sup>16</sup>. So I modified the code for part one to output the state of the registers, opcode and operand for each instruction in the program:
 ```
 IP=1, operation=bst, operand=4, reg_a=6278853, reg_b=6278850, reg_c=6278853
IP=3, operation=bxl, operand=3, reg_a=6278853, reg_b=5, reg_c=6278853
IP=5, operation=cdv, operand=5, reg_a=6278853, reg_b=6, reg_c=6278853
IP=7, operation=adv, operand=3, reg_a=6278853, reg_b=6, reg_c=98107
IP=9, operation=bxl, operand=4, reg_a=784856, reg_b=6, reg_c=98107
IP=11, operation=bxc, operand=7, reg_a=784856, reg_b=2, reg_c=98107
IP=13, operation=out, operand=5, reg_a=784856, reg_b=98105, reg_c=98107
IP=15, operation=jnz, operand=0, reg_a=784856, reg_b=98105, reg_c=98107

IP=1, operation=bst, operand=4, reg_a=784856, reg_b=98105, reg_c=98107
IP=3, operation=bxl, operand=3, reg_a=784856, reg_b=0, reg_c=98107
IP=5, operation=cdv, operand=5, reg_a=784856, reg_b=3, reg_c=98107
IP=7, operation=adv, operand=3, reg_a=784856, reg_b=3, reg_c=98107
IP=9, operation=bxl, operand=4, reg_a=98107, reg_b=3, reg_c=98107
IP=11, operation=bxc, operand=7, reg_a=98107, reg_b=7, reg_c=98107
IP=13, operation=out, operand=5, reg_a=98107, reg_b=98108, reg_c=98107
IP=15, operation=jnz, operand=0, reg_a=98107, reg_b=98108, reg_c=98107

IP=1, operation=bst, operand=4, reg_a=98107, reg_b=98108, reg_c=98107
IP=3, operation=bxl, operand=3, reg_a=98107, reg_b=3, reg_c=98107
IP=5, operation=cdv, operand=5, reg_a=98107, reg_b=0, reg_c=98107
IP=7, operation=adv, operand=3, reg_a=98107, reg_b=0, reg_c=98107
IP=9, operation=bxl, operand=4, reg_a=12263, reg_b=0, reg_c=98107
IP=11, operation=bxc, operand=7, reg_a=12263, reg_b=4, reg_c=98107
IP=13, operation=out, operand=5, reg_a=12263, reg_b=98111, reg_c=98107
IP=15, operation=jnz, operand=0, reg_a=12263, reg_b=98111, reg_c=98107

IP=1, operation=bst, operand=4, reg_a=12263, reg_b=98111, reg_c=98107
IP=3, operation=bxl, operand=3, reg_a=12263, reg_b=7, reg_c=98107
IP=5, operation=cdv, operand=5, reg_a=12263, reg_b=4, reg_c=98107
IP=7, operation=adv, operand=3, reg_a=12263, reg_b=4, reg_c=766
IP=9, operation=bxl, operand=4, reg_a=1532, reg_b=4, reg_c=766
IP=11, operation=bxc, operand=7, reg_a=1532, reg_b=0, reg_c=766
IP=13, operation=out, operand=5, reg_a=1532, reg_b=766, reg_c=766
IP=15, operation=jnz, operand=0, reg_a=1532, reg_b=766, reg_c=766

IP=1, operation=bst, operand=4, reg_a=1532, reg_b=766, reg_c=766
IP=3, operation=bxl, operand=3, reg_a=1532, reg_b=4, reg_c=766
IP=5, operation=cdv, operand=5, reg_a=1532, reg_b=7, reg_c=766
IP=7, operation=adv, operand=3, reg_a=1532, reg_b=7, reg_c=11
IP=9, operation=bxl, operand=4, reg_a=191, reg_b=7, reg_c=11
IP=11, operation=bxc, operand=7, reg_a=191, reg_b=3, reg_c=11
IP=13, operation=out, operand=5, reg_a=191, reg_b=8, reg_c=11
IP=15, operation=jnz, operand=0, reg_a=191, reg_b=8, reg_c=11

IP=1, operation=bst, operand=4, reg_a=191, reg_b=8, reg_c=11
IP=3, operation=bxl, operand=3, reg_a=191, reg_b=7, reg_c=11
IP=5, operation=cdv, operand=5, reg_a=191, reg_b=4, reg_c=11
IP=7, operation=adv, operand=3, reg_a=191, reg_b=4, reg_c=11
IP=9, operation=bxl, operand=4, reg_a=23, reg_b=4, reg_c=11
IP=11, operation=bxc, operand=7, reg_a=23, reg_b=0, reg_c=11
IP=13, operation=out, operand=5, reg_a=23, reg_b=11, reg_c=11
IP=15, operation=jnz, operand=0, reg_a=23, reg_b=11, reg_c=11

IP=1, operation=bst, operand=4, reg_a=23, reg_b=11, reg_c=11
IP=3, operation=bxl, operand=3, reg_a=23, reg_b=7, reg_c=11
IP=5, operation=cdv, operand=5, reg_a=23, reg_b=4, reg_c=11
IP=7, operation=adv, operand=3, reg_a=23, reg_b=4, reg_c=1
IP=9, operation=bxl, operand=4, reg_a=2, reg_b=4, reg_c=1
IP=11, operation=bxc, operand=7, reg_a=2, reg_b=0, reg_c=1
IP=13, operation=out, operand=5, reg_a=2, reg_b=1, reg_c=1
IP=15, operation=jnz, operand=0, reg_a=2, reg_b=1, reg_c=1
```
IP is a pointer to where in the memory the program reads the instruction, operation is the instruction, operand the operand and reg_a, reg_b, and reg_c the registers. As seen the instructions repeat in groups of 8, at least for my puzzle input. The instruction out outputs a register to the output buffer. The instruction jnz sets the pointer to a new location, in this case it jumps to the first instruction. Worth to note is that not only does the instructions repeat, but also the operands. And there are one repetition of the instructions per value sent to the output buffer. When I had come this far I had to sot for the day, making this the first day I didn't finnish both problems. I had also run out of ideas of how to solve the problem, so I looked for clues from hos others had solved part two. Most solution descriptions talked about shifting bits, which in conclusion with the number of times "3 bits" occurs in the problem description made it rather apparent that I had missed an important clue. So I looked at the repeated instructions and rewrote them as a function that takes the contents of the three registers and returns the value written to the output buffer.
```
reg_b = reg_a % 8
reg_b = reg_b ⊻ 3
reg_c = Int(floor(reg_a / 2^reg_b))
reg_a = Int(floor(reg_a / 8))
reg_b = reg_b ⊻ 4
reg_b = reg_b ⊻ reg_c
return reg_b % 8
```
Or using bitshifting and returning both the end state of reg_a and the value outputed:
```
    reg_b = reg_a % 8
    reg_b = reg_b ⊻ 3
    reg_c = reg_a >> reg_b
    reg_a = reg_a >> 3
    reg_b = reg_b ⊻ 4
    reg_b = reg_b ⊻ reg_c
    return (reg_a, reg_b % 8)
```
Note that the initial values for reg_b and reg_c never are used, only the initial value of reg_a is used. And for each execution the function shifts the value in reg_a 3 bits to the right. From looking at the instructions reg_a takes on two values each iteration, the initial value and the end value. The initial value for reg_a is always the end value shifted 3 bits to the left plus a value in the interval 0 - 7. These observations made the problem easily solvable. First I implemented a function that takes the end state for reg_a and the number to be written to the output buffer and iterates through 0 to 7 checking if the function above returns the correct output value, if it does return the value of reg_a. And since the program only stops when reg_a is 0 when the jump instructions is executed the last state of reg_a is known. So to solve the problem just call the solve function using the end state of reg_a and the target output value, in this case 0, 0. And voila, the inital state of reg_a has to be 2! Now repeat this for each of the other values that we want the program to write to the output buffer. For some combinations of output values and end states for reg_a there were several possible solutions, so I wrote a BFS that tries each posible solution looking for the minimum value that reg_a has to have for the program to write itself to the output buffer.
It think that sums up the gist of it. This was by far the hardest problem so far.

## Day 18: RAM Run
You are in a computer(?) and need to navigate through it's degrading memory. Each nanosecond a destructive byte falls down corrupting a memory location (blocking it). You need to simulate the bytes that has fallen after 1024 nanoseconds and find the shortest path from the start to the end of the memory.
### Part one
In part one you just need to find the shortest path from the start to end after 1024 bytes has been corrupted. This is a grid problem that doesn't need a grid! The bytes are already stored in a list in the order they fall. This makes it easy, we can just consider the first 1024 entries in the list and then find the shortest path checking so that we don't enter a currupted location. I implemented this as a BFS, storing the path when reaching the end.
```
BenchmarkTools.Trial: 105 samples with 1 evaluation.
 Range (min … max):  44.016 ms … 60.763 ms  ┊ GC (min … max): 21.44% … 33.20%
 Time  (median):     47.443 ms              ┊ GC (median):    23.92%
 Time  (mean ± σ):   47.636 ms ±  1.738 ms  ┊ GC (mean ± σ):  24.13% ±  1.43%

                    ▁  ▁   ▄  █▄▁  ▅                           
  ▃▁▁▁▁▃▁▃▁▁▁▃▁▃▁▁▃▁█▆██▃▆▁██▆████▆█▆▅▅▃▆▅▁▅▅▃▁▅▃▁▃▃▁▁▁▁▃▁▁▃▃ ▃
  44 ms           Histogram: frequency by time          51 ms <

 Memory estimate: 294.04 MiB, allocs estimate: 54579.
 ```
### Part two 
In part two we need to find out how many locations that can be corrupted after 1024 nanoseconds before all paths to the exit are closed. I used the same BFS as for part one. When I had a path I checked for the first corrupted location that would block this path, calulated a new path, and then continued checking the next location to be corrupted and so on. I am not happy with this solution, it takes about 2 seconds to run and allocates too much memory. Perhaps the solution from day 16 would work to find all paths between start and stop and then remove paths based on corrupted locations.
```
BenchmarkTools.Trial: 3 samples with 1 evaluation.
 Range (min … max):  1.969 s …   2.120 s  ┊ GC (min … max): 25.43% … 28.03%
 Time  (median):     2.032 s              ┊ GC (median):    26.07%
 Time  (mean ± σ):   2.040 s ± 75.805 ms  ┊ GC (mean ± σ):  26.54% ±  1.36%

  █                      █                                █  
  █▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█ ▁
  1.97 s         Histogram: frequency by time        2.12 s <

 Memory estimate: 14.19 GiB, allocs estimate: 1670302.
```

## Day 19: Linen Layout
After yesterdays headache todays easier problems was welcome. You want to sort out towels made from different arrangements of patterns. As puzzle input you are given the available patterns and a list of designs. Both the patterns and designs are made of the characters w, u, b, r, and g.
### Part one
For part one your task is to verify if the designs you are given are possible to construct using the patterns. Firstly I tried to check the designs using a que that checks if a design starts, it kinda worked but took forever to run. So memoization it is. I remplemented my solution as a recursive function that caches the result for a given string. The function checks if the design begins with each pattern, if it does it calls itself using the design with the pattern removed from the beginning. Return true if called with an empty design. If any of the patterns generate a true, the design is valid. For the memoization I used a globally declared dictionary. When called the function checks if the string denoting the design is in the dictionary. If it is return its value. At the end of the function set the key to the return value. I should really check if there is a good memoization/cache library for Julia.
```
BenchmarkTools.Trial: 10000 samples with 1 evaluation.
 Range (min … max):   73.125 μs …   3.166 s  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):      89.792 μs              ┊ GC (median):    0.00%
 Time  (mean ± σ):   412.244 μs ± 31.660 ms  ┊ GC (mean ± σ):  0.00% ± 0.00%

     ▆▅█▆▄▃▂▁▁                                                  
  ▂▅▇██████████▇▅▅▃▃▂▂▂▂▂▂▂▂▂▂▂▂▂▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ ▃
  73.1 μs         Histogram: frequency by time          197 μs <

 Memory estimate: 264 bytes, allocs estimate: 10.
 ```
### Part two
Part two was almost the same as part one. Instead of returning true if called with an empty design return 1. And instead of checking if any call returns true sum the returned values from all calls. I ran into a problem that I'm not used to from R, Julias sum function doesn't handle neither of nothing or emtpy vectors. Programatically it makes sense, but from an analytical perspecive...
```
BenchmarkTools.Trial: 10000 samples with 1 evaluation.
 Range (min … max):   82.250 μs …  10.405 ms  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     102.541 μs               ┊ GC (median):    0.00%
 Time  (mean ± σ):   122.908 μs ± 249.226 μs  ┊ GC (mean ± σ):  0.22% ± 1.49%

    ▂▅█▇                                                         
  ▃▄█████▆▄▃▃▃▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▁▂▂▂▁▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▁▂▁▁▂▂▁▁▂ ▃
  82.2 μs          Histogram: frequency by time          337 μs <

 Memory estimate: 11.45 KiB, allocs estimate: 725.
 ```

 ## Day 20: Race Condition
You are at a racetrack with **one** path from start to finish. Both you and your opponent move one step each picosecond. You are allowed to cheat one time during the race by ignoring walls so that you can move from one part of the track to another. In order to win you have to cheat when it will gain you the maximum benefit. Find how many cheats there are that will gain you at least 100 picoseconds.
 ### Part one
 In part one you are allowed to ignore walls for 2 picoseconds when you cheat. I spent too much time on this problem, the cause: I didn't include the end node when considering to where I could move when cheating. To find the path I used Dijkstras algorithm (again). My first idea was to walk through the track one step at a time and check what would happend if one wall wouldn't be there. While it worked, it took forever to run. My next idea was to walk through the track one step at the time and check where I would end up if I moved two steps in those directions that had walls. This worked better. I then generalised this idea to for each step check what later parts of the track lies within a manhattan distance of 2, I could then calculate the shortcut by subtracking the index of the former from the index of the latter minus the distance of 2 spaces between the two points.
 ```
 BenchmarkTools.Trial: 44 samples with 1 evaluation.
 Range (min … max):  105.002 ms … 152.923 ms  ┊ GC (min … max): 24.01% … 46.34%
 Time  (median):     112.830 ms               ┊ GC (median):    28.26%
 Time  (mean ± σ):   114.048 ms ±   7.953 ms  ┊ GC (mean ± σ):  29.61% ±  3.93%

    █ ▂▂▂▂  ▂▂ ▂   ▂                                             
  ▅▁██████▅▅██▁█▅█▅█▁▅▅▁█▁▁▁▁▁▅▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▅ ▁
  105 ms           Histogram: frequency by time          153 ms <

 Memory estimate: 669.03 MiB, allocs estimate: 37326.
 ```
 ### Part two
 In part two the time that you can ignore walls for a cheat is increased to 20 picoseconds. The same solution from part one worked with the addition of finding all latter parts of the path that is within a manhattan distance of no more than 20 and then take the difference between indices minus the manhattan distance between the points. At first this solution took ~10 s to run, but after realising that I already had the indices for all points and thus being able to remove all unnecesary searches for indices and a few other optimisations I managed to reduce the runtime to ~110 ms. Pretty happy about that.
 ```
 BenchmarkTools.Trial: 42 samples with 1 evaluation.
 Range (min … max):  101.116 ms … 158.581 ms  ┊ GC (min … max): 20.59% … 48.68%
 Time  (median):     109.158 ms               ┊ GC (median):    25.74%
 Time  (mean ± σ):   118.791 ms ±  18.795 ms  ┊ GC (mean ± σ):  31.44% ±  9.08%

      ▃ █ ▁                                                      
  ▄▇▄▇█▄█▇█▇▇▄▁▇▁▁▄▄▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▄▄▁▁▁▁▇▁▄▄▇▄▁▁▄▁▁▁▄ ▁
  101 ms           Histogram: frequency by time          159 ms <

 Memory estimate: 673.43 MiB, allocs estimate: 37338.
 ```

 ## Day 21:
 ### Part one
 ```
 ```
 ### Part two
 ```
 ```

 ## Day 22:
 ### Part one
 ```
 ```
 ### Part two
 ```
 ```

 ## Day 23:
 ### Part one
 ```
 ```
 ### Part two
 ```
 ```

 ## Day 24:
 ### Part one
 ```
 ```
 ### Part two
 ```
 ```

 ## Day 25:
 ### Part one
 ```
 ```
 ### Part two
 ```
 ```