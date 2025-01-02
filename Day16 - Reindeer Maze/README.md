# Day 16: Reindeer Maze

It's time again for the Reindeer Olympics! This year, the big event is the **Reindeer Maze**, where the Reindeer compete for the **<ins>lowest score</ins>**.

You and The Historians arrive to search for the Chief right as the event is about to start. It wouldn't hurt to watch a little, right?

The Reindeer start on the Start Tile (marked `S`) facing **East** and need to reach the End Tile (marked `E`). They can move forward one tile at a time (increasing their score by `1` point), but never into a wall (`#`). They can also rotate clockwise or counterclockwise 90 degrees at a time (increasing their score by `1000` points).

To figure out the best place to sit, you start by grabbing a map (your puzzle input) from a nearby kiosk. For example:

```
###############
#.......#....E#
#.#.###.#.###.#
#.....#.#...#.#
#.###.#####.#.#
#.#.#.......#.#
#.#.#####.###.#
#...........#.#
###.#.#####.#.#
#...#.....#.#.#
#.#.#.###.#.#.#
#.....#...#.#.#
#.###.#.#.#.#.#
#S..#.....#...#
###############
```

There are many paths through this maze, but taking any of the best paths would incur a score of only **`7036`**. This can be achieved by taking a total of `36` steps forward and turning 90 degrees a total of `7` times:

```
###############
#.......#....E#
#.#.###.#.###^#
#.....#.#...#^#
#.###.#####.#^#
#.#.#.......#^#
#.#.#####.###^#
#..>>>>>>>>v#^#
###^#.#####v#^#
#>>^#.....#v#^#
#^#.#.###.#v#^#
#^....#...#v#^#
#^###.#.#.#v#^#
#S..#.....#>>^#
###############
```

Here's a second example:

```
#################
#...#...#...#..E#
#.#.#.#.#.#.#.#.#
#.#.#.#...#...#.#
#.#.#.#.###.#.#.#
#...#.#.#.....#.#
#.#.#.#.#.#####.#
#.#...#.#.#.....#
#.#.#####.#.###.#
#.#.#.......#...#
#.#.###.#####.###
#.#.#...#.....#.#
#.#.#.#####.###.#
#.#.#.........#.#
#.#.#.#########.#
#S#.............#
#################
```

In this maze, the best paths cost **`11048`** points; following one such path would look like this:

```
#################
#...#...#...#..E#
#.#.#.#.#.#.#.#^#
#.#.#.#...#...#^#
#.#.#.#.###.#.#^#
#>>v#.#.#.....#^#
#^#v#.#.#.#####^#
#^#v..#.#.#>>>>^#
#^#v#####.#^###.#
#^#v#..>>>>^#...#
#^#v###^#####.###
#^#v#>>^#.....#.#
#^#v#^#####.###.#
#^#v#^........#.#
#^#v#^#########.#
#S#>>^..........#
#################
```

Note that the path shown above includes one 90 degree turn as the very first move, rotating the Reindeer from facing East to facing North.

Analyze your map carefully. **What is the lowest score a Reindeer could possibly get?**

Your puzzle answer was `133584`.

## Part Two

Now that you know what the best paths look like, you can figure out the best spot to sit.

Every non-wall tile (S, ., or E) is equipped with places to sit along the edges of the tile. While determining which of these tiles would be the best spot to sit depends on a whole bunch of factors (how comfortable the seats are, how far away the bathrooms are, whether there's a pillar blocking your view, etc.), the most important factor is **whether the tile is on one of the best paths through the maze**. If you sit somewhere else, you'd miss all the action!

So, you'll need to determine which tiles are part of **any** best path through the maze, including the `S` and `E` tiles.

In the first example, there are **`45`** tiles (marked `O`) that are part of at least one of the various best paths through the maze:

```
###############
#.......#....O#
#.#.###.#.###O#
#.....#.#...#O#
#.###.#####.#O#
#.#.#.......#O#
#.#.#####.###O#
#..OOOOOOOOO#O#
###O#O#####O#O#
#OOO#O....#O#O#
#O#O#O###.#O#O#
#OOOOO#...#O#O#
#O###.#.#.#O#O#
#O..#.....#OOO#
###############
```

In the second example, there are **`64`** tiles that are part of at least one of the best paths:

```
#################
#...#...#...#..O#
#.#.#.#.#.#.#.#O#
#.#.#.#...#...#O#
#.#.#.#.###.#.#O#
#OOO#.#.#.....#O#
#O#O#.#.#.#####O#
#O#O..#.#.#OOOOO#
#O#O#####.#O###O#
#O#O#..OOOOO#OOO#
#O#O###O#####O###
#O#O#OOO#..OOO#.#
#O#O#O#####O###.#
#O#O#OOOOOOO..#.#
#O#O#O#########.#
#O#OOO..........#
#################
```

Analyze your map further. **How many tiles are part of at least one of the best paths through the maze?**

Your puzzle answer was `622`.

**Both parts of this puzzle are complete! They provide two gold stars: \*\***

## My solution
You have a maze and want to find the shortest path from the start to the exit. Taking one step costs 1, turning 90° costs 1000. This makes the maze a weighted graph.
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