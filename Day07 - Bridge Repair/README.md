# Day 7: Bridge Repair

The Historians take you to a familiar rope bridge over a river in the middle of a jungle. The Chief isn't on this side of the bridge, though; maybe he's on the other side?

When you go to cross the bridge, you notice a group of engineers trying to repair it. (Apparently, it breaks pretty frequently.) You won't be able to cross until it's fixed.

You ask how long it'll take; the engineers tell you that it only needs final calibrations, but some young elephants were playing nearby and **stole all the operators** from their calibration equations! They could finish the calibrations if only someone could determine which test values could possibly be produced by placing any combination of operators into their calibration equations (your puzzle input).

For example:

```
190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20
```

Each line represents a single equation. The test value appears before the colon on each line; it is your job to determine whether the remaining numbers can be combined with operators to produce the test value.

Operators are **always evaluated left-to-right**, **not** according to precedence rules. Furthermore, numbers in the equations cannot be rearranged. Glancing into the jungle, you can see elephants holding two different types of operators: **add** (`+`) and **multiply** (`*`).

Only three of the above equations can be made true by inserting operators:

- `190: 10 19` has only one position that accepts an operator: between `10` and `19`. Choosing `+` would give `29`, but choosing `*` would give the test value (`10 * 19 = 190`).
- `3267: 81 40 27` has two positions for operators. Of the four possible configurations of the operators, **two** cause the right side to match the test value: `81 + 40 * 27` and `81 * 40 + 27` both equal `3267` (when evaluated left-to-right)!
- `292: 11 6 16 20` can be solved in exactly one way: `11 + 6 * 16 + 20`.

The engineers just need the **total calibration result**, which is the sum of the test values from just the equations that could possibly be true. In the above example, the sum of the test values for the three equations listed above is 3749.

Determine which equations could possibly be true. **What is their total calibration result?**

Your puzzle answer was `2501605301465`.

--- Part Two ---

The engineers seem concerned; the total calibration result you gave them is nowhere close to being within safety tolerances. Just then, you spot your mistake: some well-hidden elephants are holding a **third type of operator**.

The concatenation operator (`||`) combines the digits from its left and right inputs into a single number. For example, `12 || 345` would become `12345`. All operators are still evaluated left-to-right.

Now, apart from the three equations that could be made true using only addition and multiplication, the above example has three more equations that can be made true by inserting operators:

- `156: 15 6` can be made true through a single concatenation: `15 || 6 = 156`.
- `7290: 6 8 6 15` can be made true using `6 * 8 || 6 * 15`.
- `192: 17 8 14` can be made true using `17 || 8 + 14`.

Adding up all six test values (the three that could be made before using only + and * plus the new three that can now be made by also using ||) produces the new **total calibration result** of **`11387`**.

Using your new knowledge of elephant hiding spots, determine which equations could possibly be true. **What is their total calibration result?**

Your puzzle answer was `44841372855953`.

**Both parts of this puzzle are complete! They provide two gold stars: \*\***

## My solution
Another easy day if you have a lot of processor to work with. Recursivly build a tree of numbers based on a set of possible permutations of operators. Count those that are the same as the target number.
### Part one
For part one you have the operators + and *.
```
BenchmarkTools.Trial: 60 samples with 1 evaluation.
 Range (min … max):  80.466 ms … 86.277 ms  ┊ GC (min … max): 3.27% … 7.85%
 Time  (median):     83.538 ms              ┊ GC (median):    5.97%
 Time  (mean ± σ):   83.878 ms ±  1.099 ms  ┊ GC (mean ± σ):  6.39% ± 1.00%

                         ▁ ██ █▁▄▁█▁▁█     ▁   █  ▁▁ ▄ ▁▁      
  ▆▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▆▁█▆██▆████████▁▆▁▁▁█▁▁▁█▆▁██▆█▁██▆▁▁▆ ▁
  80.5 ms         Histogram: frequency by time        85.9 ms <

 Memory estimate: 110.65 MiB, allocs estimate: 2932236.

```
### Part two
For part two you'll have an additional operator: +, * and concatenation. Runs slow as heck, not happy at all with this solution. Tried using string concatenation at first, but changed to `(10^floor(Int, log10(b) + 1)) * a + b` and gained about 1 s in execution time.
```
BenchmarkTools.Trial: 3 samples with 1 evaluation.
 Range (min … max):  1.676 s …  1.683 s  ┊ GC (min … max): 7.47% … 7.75%
 Time  (median):     1.683 s             ┊ GC (median):    7.75%
 Time  (mean ± σ):   1.681 s ± 4.000 ms  ┊ GC (mean ± σ):  7.66% ± 0.17%

  █                                                   █  █  
  █▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁█ ▁
  1.68 s        Histogram: frequency by time        1.68 s <

 Memory estimate: 2.72 GiB, allocs estimate: 68144694.
```
