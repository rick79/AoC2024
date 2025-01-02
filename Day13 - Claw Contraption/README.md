# Day 13: Claw Contraption

Next up: the lobby of a resort on a tropical island. The Historians take a moment to admire the hexagonal floor tiles before spreading out.

Fortunately, it looks like the resort has a new arcade! Maybe you can win some prizes from the claw machines?

The claw machines here are a little unusual. Instead of a joystick or directional buttons to control the claw, these machines have two buttons labeled `A` and `B`. Worse, you can't just put in a token and play; it costs **3 tokens** to push the `A` button and **1 token** to push the `B` button.

With a little experimentation, you figure out that each machine's buttons are configured to move the claw a specific amount to the **right** (along the `X` axis) and a specific amount **forward** (along the `Y` axis) each time that button is pressed.

Each machine contains one prize; to win the **prize**, the claw must be positioned **exactly** above the prize on both the `X` and `Y` axes.

You wonder: what is the smallest number of tokens you would have to spend to win as many prizes as possible? You assemble a list of every machine's button behavior and prize location (your puzzle input). For example:

```
Button A: X+94, Y+34
Button B: X+22, Y+67
Prize: X=8400, Y=5400

Button A: X+26, Y+66
Button B: X+67, Y+21
Prize: X=12748, Y=12176

Button A: X+17, Y+86
Button B: X+84, Y+37
Prize: X=7870, Y=6450

Button A: X+69, Y+23
Button B: X+27, Y+71
Prize: X=18641, Y=10279
```

This list describes the button configuration and prize location of four different claw machines.

For now, consider just the first claw machine in the list:

- Pushing the machine's `A` button would move the claw `94` units along the `X` axis and `34` units along the `Y` axis.
- Pushing the `B` button would move the claw `22` units along the `X` axis and `67` units along the `Y` axis.
- The prize is located at `X=8400`, `Y=5400`; this means that from the claw's initial position, it would need to move exactly `8400` units along the `X` axis and exactly `5400` units along the `Y` axis to be perfectly aligned with the prize in this machine.

The cheapest way to win the prize is by pushing the `A` button `80` times and the `B` button `40` times. This would line up the claw along the `X` axis (because `80*94 + 40*22 = 8400`) and along the `Y` axis (because `80*34 + 40*67 = 5400`). Doing this would cost `80*3` tokens for the <ins>`A` presses</ins> and `40*1` for the `B` presses, a total of **`280`** tokens.

For the second and fourth claw machines, there is no combination of `A` and `B` presses that will ever win a prize.

For the third claw machine, the cheapest way to win the prize is by pushing the `A` button `38` times and the `B` button `86` times. Doing this would cost a total of **`200`** tokens.

So, the most prizes you could possibly win is two; the minimum tokens you would have to spend to win all (two) prizes is **`480`**.

You estimate that each button would need to be pressed **no more than 100 times** to win a prize. How else would someone be expected to play?

Figure out how to win as many prizes as possible. **What is the fewest tokens you would have to spend to win all possible prizes?**

Your puzzle answer was `32026`.

## Part Two

As you go to win the first prize, you discover that the claw is nowhere near where you expected it would be. Due to a unit conversion error in your measurements, the position of every prize is actually `10000000000000` higher on both the `X` and `Y` axis!

Add `10000000000000` to the `X` and `Y` position of every prize. After making this change, the example above would now look like this:

```
Button A: X+94, Y+34
Button B: X+22, Y+67
Prize: X=10000000008400, Y=10000000005400

Button A: X+26, Y+66
Button B: X+67, Y+21
Prize: X=10000000012748, Y=10000000012176

Button A: X+17, Y+86
Button B: X+84, Y+37
Prize: X=10000000007870, Y=10000000006450

Button A: X+69, Y+23
Button B: X+27, Y+71
Prize: X=10000000018641, Y=10000000010279
```

Now, it is only possible to win a prize on the second and fourth claw machines. Unfortunately, it will take **many more than `100` presses** to do so.

Using the corrected prize coordinates, figure out how to win as many prizes as possible. **What is the fewest tokens you would have to spend to win all possible prizes?**

Your puzzle answer was `89013607072065`.

**Both parts of this puzzle are complete! They provide two gold stars: \*\***

## My solution
### Part One
You're playing with a claw machine and can describe the claws motion as a system with two linear equations: ay<sub>1</sub> + by<sub>2</sub> = c<sub>1</sub> and ax<sub>1</sub>+bx<sub>2</sub>=c<sub>2</sub>. You move the claw by pushing one of two buttons (a and b) and it moves by y<sub>1</sub>, x<sub>1</sub> or y<sub>2</sub>, x<sub>2</sub> depending on which button you press. For each claw machine you have a target coordinate c<sub>1</sub>, c<sub>2</sub> that you want to reach. Solve for integer solutions.
```
BenchmarkTools.Trial: 9090 samples with 1 evaluation.
 Range (min … max):   52.208 μs …   2.838 s  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):      64.583 μs              ┊ GC (median):    0.00%
 Time  (mean ± σ):   589.043 μs ± 35.571 ms  ┊ GC (mean ± σ):  0.00% ± 0.00%

         ▅█▇▃▁                                                  
  ▁▂▂▂▂▄▇█████▇▅▄▃▃▃▂▂▂▂▂▂▂▂▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ ▂
  52.2 μs         Histogram: frequency by time          127 μs <

 Memory estimate: 2.84 KiB, allocs estimate: 14.
```
### Part Two
I must admit that I didn't read the instructions that well before I started so I didn't see that the problem was a system of linear equations before I already had solved part one using loops. Firstly I rewrote the system as matrix A and the target point as a vector b and solved the system using `A\b´. Surprisingly this didn't work that well since there seems to be a very small error when doing this calculation for one of the machines in the test data. But since it is a very small system with only two unknowns it was easy to use substitution to solve it. The discrepancy in runtbime between part on and part two depends on that I had to copy the input data when running the benchmark tests because I add 10000000000000 to the prize positions and thus mutating the structs used for storing the claw machine data.
```
BenchmarkTools.Trial: 9187 samples with 1 evaluation.
 Range (min … max):  147.125 μs …   4.701 s  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     162.541 μs              ┊ GC (median):    0.00%
 Time  (mean ± σ):   953.178 μs ± 54.649 ms  ┊ GC (mean ± σ):  0.61% ± 5.35%

  ▂▆█▇▅▅▄▃▂▁▁                                                  ▂
  █████████████▇█▆▇▆▆▇▆▆▆▅▅▆▄▄▄▄▆▄▅▄▄▃▄▄▁▃▃▃▄▁▁▃▃▁▁▁▁▁▁▁▁▁▁▁▁▃ █
  147 μs        Histogram: log(frequency) by time       467 μs <

 Memory estimate: 95.14 KiB, allocs estimate: 2204.
```