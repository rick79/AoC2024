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
Didn't learn anything new =\


## Day 19: Linen Layout
Didn't learn anything new =(

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
