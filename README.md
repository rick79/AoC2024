# Advent of Code 2024
Trying to learn Julia this year.
### Day 1
Staring with two easy problems. Learned about broadcasting and working with arrays in Julia. Both part one and part two were solved in one line each after the input was parsed.
### Day 2
Another day with simple problems where you check if a list of numbers are in eihter increasing och decreasing order. In part two you check if the lists not in order can be made to be in order if you remove an element. Learned about constructing arrays with [x for x in y]. I foresee that my code will be less readable from now on.
### Day 3
This day was solved easily with regex. Learned how to use regex in Julia and how to work with matrices.
### Day 4
Day 4 was a xmas mess. Not that the problems were that hard, just that my solution was tedious. Solved both part one and part two by iterating through a matrix looking for patterns using conditional statements. Learned about the shorthand condition && dothisiftrue. My code will from now on be even less readable.
### Day 5
Part one was about if a list of numbers fulfills a set of rules. Part two was about using the rulecheking to sort a list of numbers so that they adhere to the rules. Learned about anonymous functions as arguments.
### Day 6
Part one was about walking about in a matrix turning 90 degrees to the right if you encounter an obstacle, solved by walking step by step. The solution could be sped up by determining how many steps you can take before you encounter a obstacle and mark all these as visited, something that I'd be able to do easily in R. Part two was a bit trickier, now we're looking to create an infinite loop in the path from part one by adding an additional obstacle. Solved by iterating through the path visited in part one checking what would happend if there was an obstacle added there. So basically brute-forcing the problem. Learned about using tuples and unpacking tuples returned from functions.
### Day 7
Another easy day. Build a tree based on a set of possible permutations of operators (+ and * for part one and +, * and concatenation for part two). Learned about using recursive functions and first class functions.
