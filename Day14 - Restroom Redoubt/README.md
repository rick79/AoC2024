# Day 14: Restroom Redoubt ---

One of The Historians needs to use the bathroom; fortunately, you know there's a bathroom near an unvisited location on their list, and so you're all quickly teleported directly to the lobby of Easter Bunny Headquarters.

Unfortunately, EBHQ seems to have "improved" bathroom security **again** after your last visit. The area outside the bathroom is swarming with robots!

To get The Historian safely to the bathroom, you'll need a way to predict where the robots will be in the future. Fortunately, they all seem to be moving on the tile floor in predictable **straight lines**.

You make a list (your puzzle input) of all of the robots' current **positions** (p) and velocities (v), one robot per line. For example:

```
p=0,4 v=3,-3
p=6,3 v=-1,-3
p=10,3 v=-1,2
p=2,0 v=2,-1
p=0,0 v=1,3
p=3,0 v=-2,-2
p=7,6 v=-1,-3
p=3,0 v=-1,-2
p=9,3 v=2,3
p=7,3 v=-1,2
p=2,4 v=2,-3
p=9,5 v=-3,-3
```

Each robot's position is given as `p=x,y` where `x` represents the number of tiles the robot is from the left wall and `y` represents the number of tiles from the top wall (when viewed from above). So, a position of `p=0,0` means the robot is all the way in the top-left corner.

Each robot's velocity is given as `v=x,y` where `x` and `y` are given in **tiles per second**. Positive `x` means the robot is moving to the **right**, and positive `y` means the robot is moving **down**. So, a velocity of `v=1,-2` means that each second, the robot moves `1` tile to the right and `2` tiles up.

The robots outside the actual bathroom are in a space which is `101` tiles wide and `103` tiles tall (when viewed from above). However, in this example, the robots are in a space which is only `11` tiles wide and `7` tiles tall.

The robots are good at navigating over/under each other (due to a combination of springs, extendable legs, and quadcopters), so they can share the same tile and don't interact with each other. Visually, the number of robots on each tile in this example looks like this:

```
1.12.......
...........
...........
......11.11
1.1........
.........1.
.......1...
```

These robots have a unique feature for maximum bathroom security: they can **teleport**. When a robot would run into an edge of the space they're in, they instead **teleport to the other side**, effectively wrapping around the edges. Here is what robot `p=2,4 v=2,-3` does for the first few seconds:

```
Initial state:
...........
...........
...........
...........
..1........
...........
...........

After 1 second:
...........
....1......
...........
...........
...........
...........
...........

After 2 seconds:
...........
...........
...........
...........
...........
......1....
...........

After 3 seconds:
...........
...........
........1..
...........
...........
...........
...........

After 4 seconds:
...........
...........
...........
...........
...........
...........
..........1

After 5 seconds:
...........
...........
...........
.1.........
...........
...........
...........
```

The Historian can't wait much longer, so you don't have to simulate the robots for very long. Where will the robots be after `100` seconds?

In the above example, the number of robots on each tile after `100` seconds has elapsed looks like this:

```
......2..1.
...........
1..........
.11........
.....1.....
...12......
.1....1....
```

To determine the safest area, count the number of **robots in each quadrant** after 100 seconds. Robots that are exactly in the middle (horizontally or vertically) don't count as being in any quadrant, so the only relevant robots are:

```
..... 2..1.
..... .....
1.... .....
           
..... .....
...12 .....
.1... 1....
```

In this example, the quadrants contain `1`, `3`, `4`, and `1` robot. Multiplying these together gives a total safety factor of `12`.

Predict the motion of the robots in your list within a space which is `101` tiles wide and `103` tiles tall. **What will the safety factor be after exactly 100 seconds have elapsed?**

Your puzzle answer was `222062148`.

## Part Two

During the bathroom break, someone notices that these robots seem awfully similar to ones built and used at the North Pole. If they're the same type of robots, they should have a hard-coded <ins>Easter egg</ins>: very rarely, most of the robots should arrange themselves into **a picture of a Christmas tree**.

**What is the fewest number of seconds that must elapse for the robots to display the Easter egg?**

Your puzzle answer was `7520`.

**Both parts of this puzzle are complete! They provide two gold stars: \*\***

## My solution
### Part One
The first part was pretty straigt forward. Simulate where the robots are after 100 seconds and calculate a score based on the multiple of robots in each quadrant of the room. Robots that are in the middle horizontal and vertical lines does not count. Just increase each robots position with the velocity * number of seconds (100). Take the y component modulo the height and the x component modulo the width to account for robots moving of the right and bottom edges. If a robot has a negative position move it to the other side of the room to account for robots moving of the top and left edges. Calulate the score by multiplying the number of robots in each quadrant of the room discounting robots that are on either of the middle lines.
```
BenchmarkTools.Trial: 7911 samples with 1 evaluation.
 Range (min … max):  173.000 μs …   3.214 s  ┊ GC (min … max): 0.00% …  0.00%
 Time  (median):     196.375 μs              ┊ GC (median):    0.00%
 Time  (mean ± σ):   628.057 μs ± 36.133 ms  ┊ GC (mean ± σ):  3.05% ± 11.07%

  ▇█▆▅▃▂▁                                                      ▁
  █████████▇▇▆▆▆▃▄▁▄▁▁▄▁▁▁▁▅▄▅▃▃▄▁▁▁▄▆▃▄▄▃▁▁▃▄▄▅▄▅▅▆▄▅▅▄▄▄▄▄▄▃ █
  173 μs        Histogram: log(frequency) by time      1.08 ms <

 Memory estimate: 320.10 KiB, allocs estimate: 1948.
```

### Part Two
Part two was trickier. Now you want to know how many seconds have to pass for the majority of the robots to form a christmas tree. Without knowing how they form the tree (large tree, small tree, edges of a tree, filled tree, etc). My first solution was to output the first 10 000 iterations to a file and manually inspect the contents for something that looked like a tree. It worked. Knowing how the tree looked my next solution was to calcuate an adjecency score for a a given state where each robot adds 0 - 4 to the score depending on how many directions there are another robot in. Then I looped through the first 10 000 iterations looking for the highest adjecency score. You could probably take a sample and calculate a mean adjecency score and look for scores that are significantly larger than this to not have to loop through so many iterations.

Looking at how others have solved part two many seems to have assumed that either each robots will have a unique position or that several robots will line up vertically or horizontally when the form the tree. Both ways work, but they are hail maries when it comes to reasoning. Some have used the Chinese Remainder-Theorem to calculate the number of seconds after finding that the robots repeat their y and x positions every 101 respective 103 seconds. This is a much nicer solution but you still need to find these intervalls. Others have calculated a mean standard deviation for the robots positions and used this to find a time where the deviation differs a lot.
```
1111111111111111111111111111111
1                             1
1                             1
1                             1
1                             1
1              1              1
1             111             1
1            11111            1
1           1111111           1
1          111111111          1
1            11111            1
1           1111111           1
1          111111111          1
1         11111111111         1
1        1111111111111        1
1          111111111          1
1         11111111111         1
1        1111111111111        1
1       111111111111111       1
1      11111111111111111      1
1        1111111111111        1
1       111111111111111       1
1      11111111111111111      1
1     1111111111111111111     1
1    111111111111111111111    1
1             111             1
1             111             1
1             111             1
1                             1
1                             1
1                             1
1                             1
1111111111111111111111111111111
```
```
BenchmarkTools.Trial: 31 samples with 1 evaluation.
 Range (min … max):  153.484 ms … 174.081 ms  ┊ GC (min … max): 26.01% … 31.56%
 Time  (median):     159.929 ms               ┊ GC (median):    28.26%
 Time  (mean ± σ):   161.631 ms ±   4.902 ms  ┊ GC (mean ± σ):  28.36% ±  1.59%

              ▄▁   █      ▁▁                                     
  ▆▁▁▁▁▁▆▁▁▁▆▆██▆▁▁█▆▆▁▆▁▁██▆▁▁▆▆▁▁▁▁▆▆▁▁▁▆▁▆▁▁▁▁▆▁▁▁▁▁▁▁▁▁▁▁▆▆ ▁
  153 ms           Histogram: frequency by time          174 ms <

 Memory estimate: 795.53 MiB, allocs estimate: 31931.
```