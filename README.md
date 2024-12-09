# Advent of Code 2024
Trying to learn Julia this year.
### Day 1
Staring with two easy problems. Both part one and part two were solved in one line each after the input was parsed. Running time for part one is ~130 μs and for part two ~400 μs. Learned about broadcasting and working with arrays in Julia. 
### Day 2
Another day with simple problems where you check if a list of numbers are in either increasing och decreasing order. In part two you check if the lists not in order can be made to be in order if you remove an element. Running time for part one is ~ 180 μs and for part two ~ 400 μs. Learned about constructing arrays with [x for x in y]. I foresee that my code will be less readable from now on. 
### Day 3
This day was solved easily with regex. Learned how to use regex in Julia and how to work with matrices. Running time for part one is ~ 380 μs and for part two ~ 300 μs.
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
