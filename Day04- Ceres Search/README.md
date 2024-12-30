# Day 4: Ceres Search

"Looks like the Chief's not here. Next!" One of The Historians pulls out a device and pushes the only button on it. After a brief flash, you recognize the interior of the Ceres monitoring station!

As the search for the Chief continues, a small Elf who lives on the station tugs on your shirt; she'd like to know if you could help her with her **word search** (your puzzle input). She only has to find one word: `XMAS`.

This word search allows words to be horizontal, vertical, diagonal, written backwards, or even overlapping other words. It's a little unusual, though, as you don't merely need to find one instance of `XMAS` - you need to find all of them. Here are a few ways `XMAS` might appear, where irrelevant characters have been replaced with .:

```
..X...
.SAMX.
.A..A.
XMAS.S
.X....
```

The actual word search will be full of letters instead. For example:

```
MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
```

In this word search, `XMAS` occurs a total of **`18`** times; here's the same word search again, but where letters not involved in any `XMAS` have been replaced with .:

```
....XXMAS.
.SAMXMS...
...S..A...
..A.A.MS.X
XMASAMX.MM
X.....XA.A
S.S.S.S.SS
.A.A.A.A.A
..M.M.M.MM
.X.X.XMASX
```

Take a look at the little Elf's word search. **How many times does `XMAS` appear?**

Your puzzle answer was `2434`.

## Part Two

The Elf looks quizzically at you. Did you misunderstand the assignment?

Looking for the instructions, you flip over the word search to find that this isn't actually an `XMAS` puzzle; it's an **<ins>X-MAS</ins>** puzzle in which you're supposed to find two `MAS` in the shape of an `X`. One way to achieve that is like this:

```
M.S
.A.
M.S
```

Irrelevant characters have again been replaced with . in the above diagram. Within the `X`, each `MAS` can be written forwards or backwards.

Here's the same example from before, but this time all of the `X-MAS`es have been kept instead:

```
.M.S......
..A..MSMS.
.M.S.MAA..
..A.ASMSM.
.M.S.M....
..........
S.S.S.S.S.
.A.A.A.A..
M.M.M.M.M.
..........
```

In this example, an `X-MAS` appears **`9`** times.

Flip the word search from the instructions back over to the word search side and try again. **How many times does an `X-MAS` appear?**

Your puzzle answer was `1835`.

**Both parts of this puzzle are complete! They provide two gold stars: \*\***

## My solution
Nothing fancy here and basically the same solution for both part one and two. Iterate through every position in the input data and look for XMAS in different directions (part one) or an X of MAS:es in different directions (part two) using conditional statements.
### Part One
```
BenchmarkTools.Trial: 10000 samples with 1 evaluation.
 Range (min … max):  265.500 μs …  16.995 ms  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     284.646 μs               ┊ GC (median):    0.00%
 Time  (mean ± σ):   298.034 μs ± 239.174 μs  ┊ GC (mean ± σ):  0.00% ± 0.00%

      ▄██▅▂                                                      
  ▁▁▂▆██████▆▆▅▄▄▃▃▃▂▂▂▂▂▂▂▂▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ ▂
  266 μs           Histogram: frequency by time          414 μs <

 Memory estimate: 280 bytes, allocs estimate: 11.
 ```
 ### Part Two
 ```
 BenchmarkTools.Trial: 9208 samples with 1 evaluation.
 Range (min … max):  158.583 μs …   3.693 s  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     178.125 μs              ┊ GC (median):    0.00%
 Time  (mean ± σ):   589.802 μs ± 38.484 ms  ┊ GC (mean ± σ):  0.00% ± 0.00%

      ▁▅▇█▆▄▂▁▁                                                 
  ▁▁▂▅██████████▇▆▅▅▄▃▃▂▃▂▂▂▂▂▂▂▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ ▃
  159 μs          Histogram: frequency by time          279 μs <

 Memory estimate: 280 bytes, allocs estimate: 11.
 ```