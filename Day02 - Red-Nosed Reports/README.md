# Day 2: Red-Nosed Reports

Fortunately, the first location The Historians want to search isn't a long walk from the Chief Historian's office.

While the Red-Nosed Reindeer nuclear fusion/fission plant appears to contain no sign of the Chief Historian, the engineers there run up to you as soon as they see you. Apparently, they still talk about the time Rudolph was saved through molecular synthesis from a single electron.

They're quick to add that - since you're already here - they'd really appreciate your help analyzing some unusual data from the Red-Nosed reactor. You turn to check if The Historians are waiting for you, but they seem to have already divided into groups that are currently searching every corner of the facility. You offer to help with the unusual data.

The unusual data (your puzzle input) consists of many **reports**, one report per line. Each report is a list of numbers called **levels** that are separated by spaces. For example:

```
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
```

This example data contains six reports each containing five levels.

The engineers are trying to figure out which reports are **safe**. The Red-Nosed reactor safety systems can only tolerate levels that are either gradually increasing or gradually decreasing. So, a report only counts as safe if both of the following are true:

- The levels are either **all increasing** or **all decreasing**.
- Any two adjacent levels differ by **at least one** and **at most three**.

In the example above, the reports can be found safe or unsafe by checking those rules:

- `7 6 4 2 1`: **Safe** because the levels are all decreasing by `1` or `2`.
- `1 2 7 8 9`: **Unsafe** because `2 7` is an increase of `5`.
- `9 7 6 2 1`: **Unsafe** because `6 2` is a decrease of `4`.
- `1 3 2 4 5`: **Unsafe** because `1 3` is increasing but `3 2` is decreasing.
- `8 6 4 4 1`: **Unsafe** because `4 4` is neither an increase or a decrease.
- `1 3 6 7 9`: **Safe** because the levels are all increasing by `1`, `2`, or `3`.

So, in this example, **`2`ÄÄ reports are **safe**.

Analyze the unusual data from the engineers. **How many reports are safe?**

Your puzzle answer was `631`.

## Part Two

The engineers are surprised by the low number of safe reports until they realize they forgot to tell you about the <ins>Problem Dampener</ins>.

The Problem Dampener is a reactor-mounted module that lets the reactor safety systems **tolerate a single bad level** in what would otherwise be a safe report. It's like the bad level never happened!

Now, the same rules apply as before, except if removing a single level from an unsafe report would make it safe, the report instead counts as safe.

More of the above example's reports are now safe:

- `7 6 4 2 1`: **Safe** without removing any level.
- `1 2 7 8 9`: **Unsafe** regardless of which level is removed.
- `9 7 6 2 1`: **Unsafe** regardless of which level is removed.
- `1 3 2 4 5`: **Safe** by removing the second level, `3`.
- `8 6 4 4 1`: **Safe** by removing the third level, `4`.
- `1 3 6 7 9`: **Safe** without removing any level.

Thanks to the Problem Dampener, **`4`** reports are actually **safe**!

Update your analysis by handling situations where the Problem Dampener can remove a single level from unsafe reports. **How many reports are now safe?**

Your puzzle answer was 665.

Both parts of this puzzle are complete! They provide two gold stars: **

## My solution
## Part one
Given a sequence of N numbers, create a boolean vector of length N-1 where the values are determined by wether the n:th number from the sequence is at a distance of at least `1` and at most `3` from the n+1:th number of the sequence and that the n:th number is less than the n+1:th. Repeat but with the n:th number being more than the n+1:th number. Multiply each boolean list to check if all the values are true.
```
BenchmarkTools.Trial: 9261 samples with 1 evaluation.
 Range (min … max):  100.208 μs …   3.946 s  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     114.958 μs              ┊ GC (median):    0.00%
 Time  (mean ± σ):   550.829 μs ± 41.002 ms  ┊ GC (mean ± σ):  1.08% ± 5.32%

        ▁▆█▇▅▂                                                  
  ▁▁▂▂▃▅██████▇▅▄▃▃▃▃▃▃▂▂▂▂▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ ▂
  100 μs          Histogram: frequency by time          189 μs <

 Memory estimate: 126.37 KiB, allocs estimate: 4013.
```
### Part two
In part two you can ignore one faulty report, so for each report check if it is in order. If not, iterate through the levels in the report and check if it is in order if you remove that level. If it is in order proceed and check the next report, otherwise check what happends if you remove the next level and so on.
```
BenchmarkTools.Trial: 10000 samples with 1 evaluation.
 Range (min … max):  278.500 μs …  20.418 ms  ┊ GC (min … max):  0.00% … 98.26%
 Time  (median):     300.166 μs               ┊ GC (median):     0.00%
 Time  (mean ± σ):   358.926 μs ± 390.809 μs  ┊ GC (mean ± σ):  12.73% ± 12.55%

  █▆▃▂▁                                                         ▁
  ██████▇▆▆▅▃▁▁▃▁▁▁▁▁▁▁▁▁▁▁▁▁▁▃▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▃▅▆▇▇▇▇▇ █
  278 μs        Histogram: log(frequency) by time       2.26 ms <

 Memory estimate: 861.87 KiB, allocs estimate: 24639.
```