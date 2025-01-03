# Day 20: Race Condition

The Historians are quite pixelated again. This time, a massive, black building looms over you - you're right outside the CPU!

While The Historians get to work, a nearby program sees that you're idle and challenges you to a **race**. Apparently, you've arrived just in time for the frequently-held **race condition** festival!

The race takes place on a particularly long and twisting code path; programs compete to see who can finish in the **fewest picoseconds**. The winner even gets their very own mutex!

They hand you a **map of the racetrack** (your puzzle input). For example:

```
###############
#...#...#.....#
#.#.#.#.#.###.#
#S#...#.#.#...#
#######.#.#.###
#######.#.#...#
#######.#.###.#
###..E#...#...#
###.#######.###
#...###...#...#
#.#####.#.###.#
#.#...#.#.#...#
#.#.#.#.#.#.###
#...#...#...###
###############
```

The map consists of track (`.`) - including the **start** (`S`) and **end** (`E`) positions (both of which also count as track) - and **walls** (`#`).

When a program runs through the racetrack, it starts at the start position. Then, it is allowed to move up, down, left, or right; each such move takes **1 picosecond**. The goal is to reach the end position as quickly as possible. In this example racetrack, the fastest time is `84` picoseconds.

Because there is only a single path from the start to the end and the programs all go the same speed, the races used to be pretty boring. To make things more interesting, they introduced a new rule to the races: programs are allowed to **cheat**.

The rules for cheating are very strict. **Exactly once** during a race, a program may disable collision for up to **2 picoseconds**. This allows the program to **pass through walls** as if they were regular track. At the end of the cheat, the program must be back on normal track again; otherwise, it will receive a segmentation fault and get disqualified.

So, a program could complete the course in 72 picoseconds (saving **12** picoseconds) by cheating for the two moves marked `1` and `2`:

```
###############
#...#...12....#
#.#.#.#.#.###.#
#S#...#.#.#...#
#######.#.#.###
#######.#.#...#
#######.#.###.#
###..E#...#...#
###.#######.###
#...###...#...#
#.#####.#.###.#
#.#...#.#.#...#
#.#.#.#.#.#.###
#...#...#...###
###############
```

Or, a program could complete the course in 64 picoseconds (saving **20** picoseconds) by cheating for the two moves marked `1` and `2`:

```
###############
#...#...#.....#
#.#.#.#.#.###.#
#S#...#.#.#...#
#######.#.#.###
#######.#.#...#
#######.#.###.#
###..E#...12..#
###.#######.###
#...###...#...#
#.#####.#.###.#
#.#...#.#.#...#
#.#.#.#.#.#.###
#...#...#...###
###############
```

This cheat saves **38** picoseconds:

```
###############
#...#...#.....#
#.#.#.#.#.###.#
#S#...#.#.#...#
#######.#.#.###
#######.#.#...#
#######.#.###.#
###..E#...#...#
###.####1##.###
#...###.2.#...#
#.#####.#.###.#
#.#...#.#.#...#
#.#.#.#.#.#.###
#...#...#...###
###############
```

This cheat saves **64** picoseconds and takes the program directly to the end:

```
###############
#...#...#.....#
#.#.#.#.#.###.#
#S#...#.#.#...#
#######.#.#.###
#######.#.#...#
#######.#.###.#
###..21...#...#
###.#######.###
#...###...#...#
#.#####.#.###.#
#.#...#.#.#...#
#.#.#.#.#.#.###
#...#...#...###
###############
```

Each cheat has a distinct **start position** (the position where the cheat is activated, just before the first move that is allowed to go through walls) and **end position**; cheats are uniquely identified by their start position and end position.

In this example, the total number of cheats (grouped by the amount of time they save) are as follows:

- There are 14 cheats that save 2 picoseconds.
- There are 14 cheats that save 4 picoseconds.
- There are 2 cheats that save 6 picoseconds.
- There are 4 cheats that save 8 picoseconds.
- There are 2 cheats that save 10 picoseconds.
- There are 3 cheats that save 12 picoseconds.
- There is one cheat that saves 20 picoseconds.
- There is one cheat that saves 36 picoseconds.
- There is one cheat that saves 38 picoseconds.
- There is one cheat that saves 40 picoseconds.
- There is one cheat that saves 64 picoseconds.

You aren't sure what the conditions of the racetrack will be like, so to give yourself as many options as possible, you'll need a list of the best cheats. **How many cheats would save you at least 100 picoseconds?**

Your puzzle answer was `1375`.

## Part Two

The programs seem perplexed by your list of cheats. Apparently, the two-picosecond cheating rule was deprecated several milliseconds ago! The latest version of the cheating rule permits a single cheat that instead lasts at most **20 picoseconds**.

Now, in addition to all the cheats that were possible in just two picoseconds, many more cheats are possible. This six-picosecond cheat saves **76 picoseconds**:

```
###############
#...#...#.....#
#.#.#.#.#.###.#
#S#...#.#.#...#
#1#####.#.#.###
#2#####.#.#...#
#3#####.#.###.#
#456.E#...#...#
###.#######.###
#...###...#...#
#.#####.#.###.#
#.#...#.#.#...#
#.#.#.#.#.#.###
#...#...#...###
###############
```

Because this cheat has the same start and end positions as the one above, it's the **same cheat**, even though the path taken during the cheat is different:

```
###############
#...#...#.....#
#.#.#.#.#.###.#
#S12..#.#.#...#
###3###.#.#.###
###4###.#.#...#
###5###.#.###.#
###6.E#...#...#
###.#######.###
#...###...#...#
#.#####.#.###.#
#.#...#.#.#...#
#.#.#.#.#.#.###
#...#...#...###
###############
```

Cheats don't need to use all 20 picoseconds; cheats can last any amount of time up to and including 20 picoseconds (but can still only end when the program is on normal track). Any cheat time not used is lost; it can't be saved for another cheat later.

You'll still need a list of the best cheats, but now there are even more to choose between. Here are the quantities of cheats in this example that save **50 picoseconds or more**:

- There are 32 cheats that save 50 picoseconds.
- There are 31 cheats that save 52 picoseconds.
- There are 29 cheats that save 54 picoseconds.
- There are 39 cheats that save 56 picoseconds.
- There are 25 cheats that save 58 picoseconds.
- There are 23 cheats that save 60 picoseconds.
- There are 20 cheats that save 62 picoseconds.
- There are 19 cheats that save 64 picoseconds.
- There are 12 cheats that save 66 picoseconds.
- There are 14 cheats that save 68 picoseconds.
- There are 12 cheats that save 70 picoseconds.
- There are 22 cheats that save 72 picoseconds.
- There are 4 cheats that save 74 picoseconds.
- There are 3 cheats that save 76 picoseconds.

Find the best cheats using the updated cheating rules. **How many cheats would save you at least 100 picoseconds?**

Your puzzle answer was `983054`.

**Both parts of this puzzle are complete! They provide two gold stars: \*\***

## My solution
You are at a racetrack with **one** path from start to finish. Both you and your opponent move one step each picosecond. You are allowed to cheat one time during the race by ignoring walls so that you can move from one part of the track to another. In order to win you have to cheat when it will gain you the maximum benefit. Find how many cheats there are that will gain you at least 100 picoseconds.
 ### Part one
 In part one you are allowed to ignore walls for 2 picoseconds when you cheat. I spent too much time on this problem, the cause: I didn't include the end node when considering to where I could move when cheating. To find the path I used Dijkstras algorithm (again). My first idea was to walk through the track one step at a time and check what would happend if one wall wouldn't be there. While it worked, it took forever to run. My next idea was to walk through the track one step at the time and check where I would end up if I moved two steps in those directions that had walls. This worked better. I then generalised this idea to for each step check what later parts of the track lies within a manhattan distance of 2, I could then calculate the shortcut by subtracking the index of the former from the index of the latter minus the distance of 2 spaces between the two points.
 One funny thing, if I used CartesianIndex in a vector comprehension the run time went up to about 2 s. Don't know why!?
 ```
BenchmarkTools.Trial: 41 samples with 1 evaluation.
 Range (min … max):  110.735 ms … 160.366 ms  ┊ GC (min … max): 27.44% … 48.62%
 Time  (median):     118.234 ms               ┊ GC (median):    30.84%
 Time  (mean ± σ):   122.398 ms ±  12.644 ms  ┊ GC (mean ± σ):  33.10% ±  5.59%

   ▁  █ ▃     ▁                                                  
  ▄█▄▇█▁█▁▇▇▇▄█▄▄▄▁▄▇▄▄▁▄▁▁▁▁▁▁▄▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▄▁▁▁▁▁▁▁▁▄▁▄▄ ▁
  111 ms           Histogram: frequency by time          160 ms <

 Memory estimate: 670.17 MiB, allocs estimate: 119130.
 ```
 ### Part two
 In part two the time that you can ignore walls for a cheat is increased to 20 picoseconds. The same solution from part one worked with the addition of finding all latter parts of the path that is within a manhattan distance of no more than 20 and then take the difference between indices minus the manhattan distance between the points. At first this solution took ~10 s to run, but after realising that I already had the indices for all points and thus being able to remove all unnecesary searches for indices and a few other optimisations I managed to reduce the run time to ~110 ms. Pretty happy about that.
 ```
 BenchmarkTools.Trial: 40 samples with 1 evaluation.
 Range (min … max):  101.730 ms … 160.624 ms  ┊ GC (min … max): 20.88% … 46.62%
 Time  (median):     117.953 ms               ┊ GC (median):    28.57%
 Time  (mean ± σ):   125.846 ms ±  18.760 ms  ┊ GC (mean ± σ):  33.22% ±  8.38%

       ▁  ▁▁▄█▁ ▁  █                                 ▁ █         
  ▆▁▁▁▁█▁▁█████▁█▆▆█▆▆▁▆▁▁▁▁▁▆▆▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▆▁▁▁█▁█▁▁▁▆▆▆▆ ▁
  102 ms           Histogram: frequency by time          161 ms <

 Memory estimate: 674.57 MiB, allocs estimate: 119142.
 ```