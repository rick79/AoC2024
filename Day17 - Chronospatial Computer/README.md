# Day 17: Chronospatial Computer

The Historians push the button on their strange device, but this time, you all just feel like you're falling.

"Situation critical", the device announces in a familiar voice. "Bootstrapping process failed. Initializing debugger...."

The small handheld device suddenly unfolds into an entire computer! The Historians look around nervously before one of them tosses it to you.

This seems to be a 3-bit computer: its program is a list of 3-bit numbers (0 through 7), like `0,1,2,3`. The computer also has three **registers** named `A`, `B`, and `C`, but these registers aren't limited to 3 bits and can instead hold any integer.

The computer knows **eight instructions**, each identified by a 3-bit number (called the instruction's **opcode**). Each instruction also reads the 3-bit number after it as an input; this is called its **operand**.

A number called the **instruction pointer** identifies the position in the program from which the next opcode will be read; it starts at `0`, pointing at the first 3-bit number in the program. Except for jump instructions, the instruction pointer increases by `2` after each instruction is processed (to move past the instruction's opcode and its operand). If the computer tries to read an opcode past the end of the program, it instead **halts**.

So, the program `0,1,2,3` would run the instruction whose opcode is `0` and pass it the operand `1`, then run the instruction having opcode `2` and pass it the operand `3`, then halt.

There are two types of operands; each instruction specifies the type of its operand. The value of a **literal operand** is the operand itself. For example, the value of the literal operand `7` is the number `7`. The value of a **combo operand** can be found as follows:

- Combo operands `0` through `3` represent literal values `0` through `3`.
- Combo operand `4` represents the value of register `A`.
- Combo operand `5` represents the value of register `B`.
- Combo operand `6` represents the value of register `C`.
- Combo operand `7` is reserved and will not appear in valid programs.

The eight instructions are as follows:

The **adv** instruction (opcode **`0`**) performs **division**. The numerator is the value in the `A` register. The denominator is found by raising 2 to the power of the instruction's **combo** operand. (So, an operand of `2` would divide `A` by `4` (`2^2`); an operand of `5` would divide `A` by `2^B`.) The result of the division operation is **truncated** to an integer and then written to the A register.

The **bxl** instruction (opcode **`1`**) calculates the bitwise XOR of register `B` and the instruction's **literal** operand, then stores the result in register `B`.

The **bst** instruction (opcode **`2`**) calculates the value of its **combo** operand modulo `8` (thereby keeping only its lowest 3 bits), then writes that value to the `B` register.

The **jnz** instruction (opcode **`3`**) does **nothing** if the `A` register is `0`. However, if the `A` register is **not zero**, it <ins>**jumps**</ins> by setting the instruction pointer to the value of its **literal** operand; if this instruction jumps, the instruction pointer is **not** increased by `2` after this instruction.

The **bxc** instruction (opcode **`4`**) calculates the **bitwise XOR** of register `B` and register `C`, then stores the result in register `B`. (For legacy reasons, this instruction reads an operand but **ignores** it.)

The **out** instruction (opcode **`5`**) calculates the value of its **combo** operand modulo 8, then **outputs** that value. (If a program outputs multiple values, they are separated by commas.)

The **bdv** instruction (opcode **`6`**) works exactly like the `adv` instruction except that the result is stored in the **`B` register**. (The numerator is still read from the `A` register.)

The **cdv** instruction (opcode **`7`**) works exactly like the `adv` instruction except that the result is stored in the **`C` register**. (The numerator is still read from the `A` register.)

Here are some examples of instruction operation:

- If register `C` contains `9`, the program `2,6` would set register `B` to `1`.
- If register `A` contains `10`, the program `5,0,5,1,5,4` would output `0,1,2`.
- If register `A` contains `2024`, the program `0,1,5,4,3,0` would output `4,2,5,6,7,7,7,7,3,1,0` and leave `0` in register `A`.
- If register `B` contains `29`, the program `1,7` would set register `B` to `26`.
- If register `B` contains `2024` and register `C` contains `43690`, the program `4,0` would set register `B` to `44354`.

The Historians' strange device has finished initializing its debugger and is displaying some **information about the program** it is trying to run (your puzzle input). For example:

```
Register A: 729
Register B: 0
Register C: 0

Program: 0,1,5,4,3,0
```

Your first task is to **determine what the program is trying to output**. To do this, initialize the registers to the given values, then run the given program, collecting any output produced by out instructions. (Always join the values produced by out instructions with commas.) After the above program halts, its final output will be **`4,6,3,5,6,3,5,2,1,0`**.

Using the information provided by the debugger, initialize the registers to the given values, then run the program. Once it halts, **what do you get if you use commas to join the values it output into a single string?**

Your puzzle answer was `2,1,4,7,6,0,3,1,4`.

## Part Two

Digging deeper in the device's manual, you discover the problem: this program is supposed to **output another copy of the program**! Unfortunately, the value in register A seems to have been corrupted. You'll need to find a new value to which you can initialize register A so that the program's output instructions produce an exact copy of the program itself.

For example:

```
Register A: 2024
Register B: 0
Register C: 0

Program: 0,3,5,4,3,0
```

This program outputs a copy of itself if register `A` is instead initialized to **`117440`**. (The original initial value of register `A`, `2024`, is ignored.)

**What is the lowest positive initial value for register A that causes the program to output a copy of itself?**

Your puzzle answer was `266932601404433`.

**Both parts of this puzzle are complete! They provide two gold stars: \*\***

## My solution
This day's problem is about debugging/simulating a 3 bit computer. The computer has 3 registers that can contain arbitrarily large numbers, a memory that stores a sequence of 3 bit numbers, and an output buffer. The computer has 8 instructions that are identified by a 3 bit number opcode and has a 3 bit number operand. The instructions either operate on the registers and/or operand, jumps to a new location in memory and continue executing the program from there, or outputs a register to the output buffer. When running a program the computer reads two three bit numbers from memory, the first denoting the instruction and the second the operand, and executes the instruction. You are given an initial state for the registers and the program stored in the memory.
A keyword that's worth noting is bit, it'll become important later.
### Part one
In part one you are asked to run the program in memory by simulating the computer. I implemented the instructions as anonymous functions with one parameter (the operand) in a dictionary with the instruction opcodes as keys. Then I just iterated through the program calling the instruction function using the opcode and passing the operand as parameter. The anonymous functions then operated on the three registers and the output buffer. By running the program you build up a sequence of numbers in the output buffer that is the output of the program. This was one of the fastest problems to implement for me this year, but it took a turn for the worse in part two...
```
BenchmarkTools.Trial: 10000 samples with 1 evaluation.
 Range (min … max):   64.417 μs …   2.149 s  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):      78.208 μs              ┊ GC (median):    0.00%
 Time  (mean ± σ):   467.235 μs ± 27.487 ms  ┊ GC (mean ± σ):  0.00% ± 0.00%

          ▁▆█▇▇▃▁                                               
  ▁▂▂▂▂▂▄▆███████▇▅▄▃▃▃▂▂▂▂▂▂▂▂▂▂▂▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ ▂
  64.4 μs         Histogram: frequency by time          133 μs <

 Memory estimate: 3.13 KiB, allocs estimate: 105.
 ```
 ### Part two
 In part two the purpose of the program is to replicate itself. So instead of the output from part one you need to find an initial state for one of the registers so that the program (the same program as in part one) output itself to the output buffer. Honestly it took me quite a while to figure this one out. Bruteforcing the problen is out of question, a quick inspection of the output with various starting states showed that the register needed to be set to a value in the range of 8<sup>15</sup> - 8<sup>16</sup>. So I modified the code for part one to output the state of the registers, opcode and operand for each instruction in the program:
 ```
 IP=1, operation=bst, operand=4, reg_a=6278853, reg_b=6278850, reg_c=6278853
IP=3, operation=bxl, operand=3, reg_a=6278853, reg_b=5, reg_c=6278853
IP=5, operation=cdv, operand=5, reg_a=6278853, reg_b=6, reg_c=6278853
IP=7, operation=adv, operand=3, reg_a=6278853, reg_b=6, reg_c=98107
IP=9, operation=bxl, operand=4, reg_a=784856, reg_b=6, reg_c=98107
IP=11, operation=bxc, operand=7, reg_a=784856, reg_b=2, reg_c=98107
IP=13, operation=out, operand=5, reg_a=784856, reg_b=98105, reg_c=98107
IP=15, operation=jnz, operand=0, reg_a=784856, reg_b=98105, reg_c=98107

IP=1, operation=bst, operand=4, reg_a=784856, reg_b=98105, reg_c=98107
IP=3, operation=bxl, operand=3, reg_a=784856, reg_b=0, reg_c=98107
IP=5, operation=cdv, operand=5, reg_a=784856, reg_b=3, reg_c=98107
IP=7, operation=adv, operand=3, reg_a=784856, reg_b=3, reg_c=98107
IP=9, operation=bxl, operand=4, reg_a=98107, reg_b=3, reg_c=98107
IP=11, operation=bxc, operand=7, reg_a=98107, reg_b=7, reg_c=98107
IP=13, operation=out, operand=5, reg_a=98107, reg_b=98108, reg_c=98107
IP=15, operation=jnz, operand=0, reg_a=98107, reg_b=98108, reg_c=98107

IP=1, operation=bst, operand=4, reg_a=98107, reg_b=98108, reg_c=98107
IP=3, operation=bxl, operand=3, reg_a=98107, reg_b=3, reg_c=98107
IP=5, operation=cdv, operand=5, reg_a=98107, reg_b=0, reg_c=98107
IP=7, operation=adv, operand=3, reg_a=98107, reg_b=0, reg_c=98107
IP=9, operation=bxl, operand=4, reg_a=12263, reg_b=0, reg_c=98107
IP=11, operation=bxc, operand=7, reg_a=12263, reg_b=4, reg_c=98107
IP=13, operation=out, operand=5, reg_a=12263, reg_b=98111, reg_c=98107
IP=15, operation=jnz, operand=0, reg_a=12263, reg_b=98111, reg_c=98107

IP=1, operation=bst, operand=4, reg_a=12263, reg_b=98111, reg_c=98107
IP=3, operation=bxl, operand=3, reg_a=12263, reg_b=7, reg_c=98107
IP=5, operation=cdv, operand=5, reg_a=12263, reg_b=4, reg_c=98107
IP=7, operation=adv, operand=3, reg_a=12263, reg_b=4, reg_c=766
IP=9, operation=bxl, operand=4, reg_a=1532, reg_b=4, reg_c=766
IP=11, operation=bxc, operand=7, reg_a=1532, reg_b=0, reg_c=766
IP=13, operation=out, operand=5, reg_a=1532, reg_b=766, reg_c=766
IP=15, operation=jnz, operand=0, reg_a=1532, reg_b=766, reg_c=766

IP=1, operation=bst, operand=4, reg_a=1532, reg_b=766, reg_c=766
IP=3, operation=bxl, operand=3, reg_a=1532, reg_b=4, reg_c=766
IP=5, operation=cdv, operand=5, reg_a=1532, reg_b=7, reg_c=766
IP=7, operation=adv, operand=3, reg_a=1532, reg_b=7, reg_c=11
IP=9, operation=bxl, operand=4, reg_a=191, reg_b=7, reg_c=11
IP=11, operation=bxc, operand=7, reg_a=191, reg_b=3, reg_c=11
IP=13, operation=out, operand=5, reg_a=191, reg_b=8, reg_c=11
IP=15, operation=jnz, operand=0, reg_a=191, reg_b=8, reg_c=11

IP=1, operation=bst, operand=4, reg_a=191, reg_b=8, reg_c=11
IP=3, operation=bxl, operand=3, reg_a=191, reg_b=7, reg_c=11
IP=5, operation=cdv, operand=5, reg_a=191, reg_b=4, reg_c=11
IP=7, operation=adv, operand=3, reg_a=191, reg_b=4, reg_c=11
IP=9, operation=bxl, operand=4, reg_a=23, reg_b=4, reg_c=11
IP=11, operation=bxc, operand=7, reg_a=23, reg_b=0, reg_c=11
IP=13, operation=out, operand=5, reg_a=23, reg_b=11, reg_c=11
IP=15, operation=jnz, operand=0, reg_a=23, reg_b=11, reg_c=11

IP=1, operation=bst, operand=4, reg_a=23, reg_b=11, reg_c=11
IP=3, operation=bxl, operand=3, reg_a=23, reg_b=7, reg_c=11
IP=5, operation=cdv, operand=5, reg_a=23, reg_b=4, reg_c=11
IP=7, operation=adv, operand=3, reg_a=23, reg_b=4, reg_c=1
IP=9, operation=bxl, operand=4, reg_a=2, reg_b=4, reg_c=1
IP=11, operation=bxc, operand=7, reg_a=2, reg_b=0, reg_c=1
IP=13, operation=out, operand=5, reg_a=2, reg_b=1, reg_c=1
IP=15, operation=jnz, operand=0, reg_a=2, reg_b=1, reg_c=1
```
IP is a pointer to where in the memory the program reads the instruction, operation is the instruction, operand the operand and reg_a, reg_b, and reg_c the registers. As seen the instructions repeat in groups of 8, at least for my puzzle input. The instruction out outputs a register to the output buffer. The instruction jnz sets the pointer to a new location, in this case it jumps to the first instruction. Worth to note is that not only does the instructions repeat, but also the operands. And there are one repetition of the instructions per value sent to the output buffer. When I had come this far I had to sot for the day, making this the first day I didn't finnish both problems. I had also run out of ideas of how to solve the problem, so I looked for clues from hos others had solved part two. Most solution descriptions talked about shifting bits, which in conclusion with the number of times "3 bits" occurs in the problem description made it rather apparent that I had missed an important clue. So I looked at the repeated instructions and rewrote them as a function that takes the contents of the three registers and returns the value written to the output buffer.
```
reg_b = reg_a % 8
reg_b = reg_b ⊻ 3
reg_c = Int(floor(reg_a / 2^reg_b))
reg_a = Int(floor(reg_a / 8))
reg_b = reg_b ⊻ 4
reg_b = reg_b ⊻ reg_c
return reg_b % 8
```
Or using bitshifting and returning both the end state of reg_a and the value outputed:
```
    reg_b = reg_a % 8
    reg_b = reg_b ⊻ 3
    reg_c = reg_a >> reg_b
    reg_a = reg_a >> 3
    reg_b = reg_b ⊻ 4
    reg_b = reg_b ⊻ reg_c
    return (reg_a, reg_b % 8)
```
Note that the initial values for reg_b and reg_c never are used, only the initial value of reg_a is used. And for each execution the function shifts the value in reg_a 3 bits to the right. From looking at the instructions reg_a takes on two values each iteration, the initial value and the end value. The initial value for reg_a is always the end value shifted 3 bits to the left plus a value in the interval 0 - 7. These observations made the problem easily solvable. First I implemented a function that takes the end state for reg_a and the number to be written to the output buffer and iterates through 0 to 7 checking if the function above returns the correct output value, if it does return the value of reg_a. And since the program only stops when reg_a is 0 when the jump instructions is executed the last state of reg_a is known. So to solve the problem just call the solve function using the end state of reg_a and the target output value, in this case 0, 0. And voila, the inital state of reg_a has to be 2! Now repeat this for each of the other values that we want the program to write to the output buffer. For some combinations of output values and end states for reg_a there were several possible solutions, so I wrote a BFS that tries each posible solution looking for the minimum value that reg_a has to have for the program to write itself to the output buffer.
It think that sums up the gist of it. This was by far the hardest problem so far.
```
BenchmarkTools.Trial: 8412 samples with 1 evaluation.
 Range (min … max):   60.791 μs …   2.743 s  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):      74.583 μs              ┊ GC (median):    0.00%
 Time  (mean ± σ):   642.720 μs ± 36.685 ms  ┊ GC (mean ± σ):  0.38% ± 4.04%

       ▄█▆▂                                                     
  ▂▃▃▄▇████▇▅▄▄▃▃▃▃▃▃▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▁▁▂▂▂▂ ▃
  60.8 μs         Histogram: frequency by time          174 μs <

 Memory estimate: 46.89 KiB, allocs estimate: 604.
 ```