# Day 23: LAN Party

As The Historians wander around a secure area at Easter Bunny HQ, you come across posters for a LAN party scheduled for today! Maybe you can find it; you connect to a nearby datalink port and download a map of the local network (your puzzle input).

The network map provides a list of every **connection between two computers**. For example:

```
kh-tc
qp-kh
de-cg
ka-co
yn-aq
qp-ub
cg-tb
vc-aq
tb-ka
wh-tc
yn-cg
kh-ub
ta-co
de-co
tc-td
tb-wq
wh-td
ta-ka
td-qp
aq-cg
wq-ub
ub-vc
de-ta
wq-aq
wq-vc
wh-yn
ka-de
kh-ta
co-tc
wh-qp
tb-vc
td-yn
```

Each line of text in the network map represents a single connection; the line kh-tc represents a connection between the computer named kh and the computer named tc. Connections aren't directional; tc-kh would mean exactly the same thing.

LAN parties typically involve multiplayer games, so maybe you can locate it by finding groups of connected computers. Start by looking for **sets of three computers** where each computer in the set is connected to the other two computers.

In this example, there are `12` such sets of three inter-connected computers:

```
aq,cg,yn
aq,vc,wq
co,de,ka
co,de,ta
co,ka,ta
de,ka,ta
kh,qp,ub
qp,td,wh
tb,vc,wq
tc,td,wh
td,wh,yn
ub,vc,wq
```

If the Chief Historian is here, **and** he's at the LAN party, it would be best to know that right away. You're pretty sure his computer's name starts with t, so consider only sets of three computers where at least one computer's name starts with t. That narrows the list down to **`7`** sets of three inter-connected computers:

```
co,de,ta
co,ka,ta
de,ka,ta
qp,td,wh
tb,vc,wq
tc,td,wh
td,wh,yn
```

Find all the sets of three inter-connected computers. **How many contain at least one computer with a name that starts with t?**

Your puzzle answer was `1175`.

## Part Two

There are still way too many results to go through them all. You'll have to find the LAN party another way and go there yourself.

Since it doesn't seem like any employees are around, you figure they must all be at the LAN party. If that's true, the LAN party will be the **largest set of computers that are all connected to each other**. That is, for each computer at the LAN party, that computer will have a connection to every other computer at the LAN party.

In the above example, the largest set of computers that are all connected to each other is made up of co, de, ka, and ta. Each computer in this set has a connection to every other computer in the set:

```
ka-co
ta-co
de-co
ta-ka
de-ta
ka-de
```

The LAN party posters say that the **password** to get into the LAN party is the name of every computer at the LAN party, sorted alphabetically, then joined together with commas. (The people running the LAN party are clearly a bunch of <ins>nerds</ins>>.) In this example, the password would be **`co,de,ka,ta`**.

**What is the password to get into the LAN party?**

Your puzzle answer was `bw,dr,du,ha,mm,ov,pj,qh,tz,uv,vq,wq,xw`.

**Both parts of this puzzle are complete! They provide two gold stars: \*\***

## My solution
### Part One
Keep It Simple Stupid! Began by thinking that this is a nice graph problem, and lacking knowledge of graph libraries lets try making something that looks nice. And lets try memoization for looking up edges and vertices. Big misstake. Memoization added about 7 s to the run time (due to overhead). Using a nice looking data structure for the graph added I don't know how many seconds more. And not thinking clearly while looping added an additional 70 s(!!). When I removed everything and used dicts for keeping track of vertices and edges i managed to reduce the run time to about 1.3 s. Part one is easily solved by iterating through each vertex three times and for each iteration checking if there is an edge between the first and second vertices, the first and third vertices, and the second and third vertices. Brute force but works.
```
BenchmarkTools.Trial: 4 samples with 1 evaluation.
 Range (min … max):  1.301 s …  1.316 s  ┊ GC (min … max): 1.77% … 2.03%
 Time  (median):     1.308 s             ┊ GC (median):    2.00%
 Time  (mean ± σ):   1.308 s ± 6.407 ms  ┊ GC (mean ± σ):  1.97% ± 0.15%

  █                █                █                    █  
  █▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█ ▁
  1.3 s         Histogram: frequency by time        1.32 s <

 Memory estimate: 385.72 MiB, allocs estimate: 529754.
```
### Part Two
Part two was easier. Iterating through each vertex. Add the vertex to the group of interconnected computer and all vertices connected to this vertex to a que. While the que is not empty; pop a vertex off the que and check if this vertex is connected to every other vertex in the group; if it is add it to the group. When the que is empty check if the size of the group is larger than the previously largest group, if it is build a (possible) password. continue with the next vertex.
```
BenchmarkTools.Trial: 1553 samples with 1 evaluation.
 Range (min … max):  2.894 ms … 37.607 ms  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     3.050 ms              ┊ GC (median):    0.00%
 Time  (mean ± σ):   3.202 ms ±  1.236 ms  ┊ GC (mean ± σ):  1.96% ± 6.00%

    ▁▄█▅                                                      
  ▄▇█████▆▅▄▄▃▃▃▃▃▃▃▃▃▂▂▂▂▂▂▂▁▂▁▂▁▁▂▁▂▂▂▂▂▂▃▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂ ▃
  2.89 ms        Histogram: frequency by time        4.64 ms <

 Memory estimate: 1.19 MiB, allocs estimate: 19647.
```

