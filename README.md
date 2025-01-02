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
Learned to not rely too much on recursion instead iterating through arrays and about how to benchmark and time function calls.

## Day 10: Hoof It
Learned that the ∉ operator can be costly.

## Day 11: Plutonian Pebbles
Learned to RTFM ;)

## Day 12: Garden Groups
Learned how to use BenchmarkTools, and when refactoring my code how to work with CartesianIndex instead of tuples.

## Day 13: Claw Contraption
Learned how to use structs and mutable structs. Alsp found an interesting behaviour for matrix division where `A\b´ surprisingly didn't work that well since there seemed to be a very small error when doing this calculation for one of the machines in the test data.

## Day 14: Restroom Redoubt
Learned about file IO.

## Day 15: Warehouse Woes
Todays problems should be called the Adventures of Lolo! Didn't learn anything new =/

## Day 16: Reindeer Maze
Got to implement Dijkstras algorithm

## Day 17: Chronospatial Computer
Fun problems, but didn't learn anything new.





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

 ## Day 22:

 ## Day 23:

 ## Day 24:

 ## Day 25:
