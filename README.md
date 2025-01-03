# Advent of Code 2024
Trying to learn Julia this year. I haven't used Julia before but have some familiarity with Matlab and Python.

My goal was to solve all puzzles with a run time of at most 2 seconds, which I managed except for 3 days (one of them I solved the last part of the puzzle by hand and I need minutes not milliseconds to do things). The day with the least run time time was day 13 with part clocking in at 64.583 μs and part two at 162.541 μs. The day with the longest run time was day 22 with part one clocking in at 20.195 ms and part two at 5.199 s. Overall pretty happy with my solutions.

AoC 2024 can be found at [https://adventofcode.com/2024](https://adventofcode.com/2024)

## Day 1: Historian Hysteria
Learned about broadcasting and working with arrays in Julia. 

## Day 2: Red-Nosed Reports
Learned about constructing arrays comprehensions ([x for x in y]). I foresee that my code will be less readable from now on. 

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
Learned how to use structs and mutable structs. Alsp found an interesting behaviour for matrix division where `A\b` surprisingly didn't work that well since there seemed to be a very small error when doing this calculation for one of the machines in the test data.

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
Found something weird, if I used CartesianIndex in a vector comprehension the run time went up from 120 ms to to about 2 s.

 ## Day 21:
Really fun problem, but didn't learn anything new =[

 ## Day 22:
Didn't learn anything new today either ={

 ## Day 23:
 Learned about the Momoization library (and didn't use it because of the overhead)

 ## Day 24:
 Learned to never give up ;)

 ## Day 25:
 Didn't learn anything new =|