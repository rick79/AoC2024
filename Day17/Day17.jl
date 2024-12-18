#=
--- Day 17: Chronospatial Computer ---

The Historians push the button on their strange device, but this time, you all 
just feel like you're falling.

"Situation critical", the device announces in a familiar voice. "Bootstrapping 
process failed. Initializing debugger...."

The small handheld device suddenly unfolds into an entire computer! The 
Historians look around nervously before one of them tosses it to you.

This seems to be a 3-bit computer: its program is a list of 3-bit numbers (0 
through 7), like 0,1,2,3. The computer also has three registers named A, B, 
and C, but these registers aren't limited to 3 bits and can instead hold any 
integer.

The computer knows eight instructions, each identified by a 3-bit number 
(called the instruction's opcode). Each instruction also reads the 3-bit 
number after it as an input; this is called its operand.

A number called the instruction pointer identifies the position in the program 
from which the next opcode will be read; it starts at 0, pointing at the first 
3-bit number in the program. Except for jump instructions, the instruction 
pointer increases by 2 after each instruction is processed (to move past the 
instruction's opcode and its operand). If the computer tries to read an opcode 
past the end of the program, it instead halts.

So, the program 0,1,2,3 would run the instruction whose opcode is 0 and pass 
it the operand 1, then run the instruction having opcode 2 and pass it the 
operand 3, then halt.

There are two types of operands; each instruction specifies the type of its 
operand. The value of a literal operand is the operand itself. For example, 
the value of the literal operand 7 is the number 7. The value of a combo 
operand can be found as follows:

    - Combo operands 0 through 3 represent literal values 0 through 3.
    - Combo operand 4 represents the value of register A.
    - Combo operand 5 represents the value of register B.
    - Combo operand 6 represents the value of register C.
    - Combo operand 7 is reserved and will not appear in valid programs.

The eight instructions are as follows:

The adv instruction (opcode 0) performs division. The numerator is the value 
in the A register. The denominator is found by raising 2 to the power of the 
instruction's combo operand. (So, an operand of 2 would divide A by 4 (2^2); 
an operand of 5 would divide A by 2^B.) The result of the division operation 
is truncated to an integer and then written to the A register.

The bxl instruction (opcode 1) calculates the bitwise XOR of register B and 
the instruction's literal operand, then stores the result in register B.

The bst instruction (opcode 2) calculates the value of its combo operand 
modulo 8 (thereby keeping only its lowest 3 bits), then writes that value to 
the B register.

The jnz instruction (opcode 3) does nothing if the A register is 0. However, 
if the A register is not zero, it jumps by setting the instruction pointer to 
the value of its literal operand; if this instruction jumps, the instruction 
pointer is not increased by 2 after this instruction.

The bxc instruction (opcode 4) calculates the bitwise XOR of register B and 
register C, then stores the result in register B. (For legacy reasons, this 
instruction reads an operand but ignores it.)

The out instruction (opcode 5) calculates the value of its combo operand 
modulo 8, then outputs that value. (If a program outputs multiple values, they 
are separated by commas.)

The bdv instruction (opcode 6) works exactly like the adv instruction except 
that the result is stored in the B register. (The numerator is still read from 
the A register.)

The cdv instruction (opcode 7) works exactly like the adv instruction except 
that the result is stored in the C register. (The numerator is still read from 
the A register.)

Here are some examples of instruction operation:

    - If register C contains 9, the program 2,6 would set register B to 1.
    - If register A contains 10, the program 5,0,5,1,5,4 would output 0,1,2.
    - If register A contains 2024, the program 0,1,5,4,3,0 would output 4,2,5,
      6,7,7,7,7,3,1,0 and leave 0 in register A.
    - If register B contains 29, the program 1,7 would set register B to 26.
    - If register B contains 2024 and register C contains 43690, the program 
      4,0 would set register B to 44354.

The Historians' strange device has finished initializing its debugger and is 
displaying some information about the program it is trying to run (your puzzle 
input). For example:

Register A: 729
Register B: 0
Register C: 0

Program: 0,1,5,4,3,0

Your first task is to determine what the program is trying to output. To do 
this, initialize the registers to the given values, then run the given 
program, collecting any output produced by out instructions. (Always join the 
values produced by out instructions with commas.) After the above program 
halts, its final output will be 4,6,3,5,6,3,5,2,1,0.

Using the information provided by the debugger, initialize the registers to 
the given values, then run the program. Once it halts, what do you get if 
you use commas to join the values it output into a single string?

Your puzzle answer was 2,1,4,7,6,0,3,1,4.

--- Part Two ---

Digging deeper in the device's manual, you discover the problem: this program 
is supposed to output another copy of the program! Unfortunately, the value in 
register A seems to have been corrupted. You'll need to find a new value to 
which you can initialize register A so that the program's output instructions 
produce an exact copy of the program itself.

For example:

Register A: 2024
Register B: 0
Register C: 0

Program: 0,3,5,4,3,0

This program outputs a copy of itself if register A is instead initialized to 
117440. (The original initial value of register A, 2024, is ignored.)

What is the lowest positive initial value for register A that causes the 
program to output a copy of itself?

Your puzzle answer was 266932601404433.

Both parts of this puzzle are complete! They provide two gold stars: **
=#

function read_data(path::String)
    data = read(path, String)
    reg_a = parse(Int, match(r"(?<=Register A: )(\d+)", data)[1])
    reg_b = parse(Int, match(r"(?<=Register B: )(\d+)", data)[1])
    reg_c = parse(Int, match(r"(?<=Register C: )(\d+)", data)[1])
    memory = parse.(Int, split(match(r"(?<=Program: ).*", data).match, ","))
    return (reg_a, reg_b, reg_c, memory)
end


#=

function opcode2instruction(opcode::Int)
    opcode == 0 && return "adv"
    opcode == 1 && return "bxl"
    opcode == 2 && return "bst"
    opcode == 3 && return "jnz"
    opcode == 4 && return "bxc"
    opcode == 5 && return "out"
    opcode == 6 && return "bdv"
    opcode == 7 && return "cdv"
end

function print_instructions(data::Tuple{Int, Int, Int, Vector{Int}})
    instructions = Dict([
        0 => operand -> reg_a = Int(floor(reg_a/(2^combo_operand(operand, reg_a, reg_b, reg_c)))),
        1 => operand -> reg_b = reg_b ⊻ operand,
        2 => operand -> reg_b = combo_operand(operand, reg_a, reg_b, reg_c) % 8,
        3 => operand -> (reg_a != 0) && (ip = operand - 1),
        4 => operand -> reg_b = reg_b ⊻ reg_c,
        5 => operand -> push!(output, combo_operand(operand, reg_a, reg_b, reg_c) % 8),
        6 => operand -> reg_b = Int(floor(reg_a/(2^combo_operand(operand, reg_a, reg_b, reg_c)))),
        7 => operand -> reg_c = Int(floor(reg_a/(2^combo_operand(operand, reg_a, reg_b, reg_c))))
    ])
    (reg_a, reg_b, reg_c, memory) = data
    output = Vector{Int}()
    state = Vector{Tuple{Int, String, Int, Int, Int, Int}}()
    ip = 1
    while ip < length(memory)
        push!(state, (ip, opcode2instruction(memory[ip]), memory[ip+1], reg_a, reg_b, reg_c))
        instructions[memory[ip]](memory[ip+1])
        ip = ip + 2
    end
    for s ∈ state
        println("IP=$(s[1]), operation=$(s[2]), operand=$(s[3]), reg_a=$(s[4]), reg_b=$(s[5]), reg_c=$(s[6])")
    end
    println("reg_a=$reg_a, reg_b=$reg_b, reg_c=r$reg_c")
    println(join(output, ","))
end

function cycle(reg_a::Int)
    reg_b = reg_a % 8
    reg_b = reg_b ⊻ 3
    reg_c = reg_a >> reg_b
    reg_a = reg_a >> 3
    reg_b = reg_b ⊻ 4
    reg_b = reg_b ⊻ reg_c
    return (reg_a, reg_b % 8)
end
=#

function combo_operand(operand::Int, reg_a::Int, reg_b::Int, reg_c::Int)
    (operand <=3) && return operand
    (operand == 4) && return reg_a
    (operand == 5) && return reg_b
    (operand == 6) && return reg_c
end

function run_program(data::Tuple{Int, Int, Int, Vector{Int}})
    instructions = Dict([
        0 => operand -> reg_a = Int(floor(reg_a/(2^combo_operand(operand, reg_a, reg_b, reg_c)))),
        1 => operand -> reg_b = reg_b ⊻ operand,
        2 => operand -> reg_b = combo_operand(operand, reg_a, reg_b, reg_c) % 8,
        3 => operand -> (reg_a != 0) && (ip = operand - 1),
        4 => operand -> reg_b = reg_b ⊻ reg_c,
        5 => operand -> push!(output, combo_operand(operand, reg_a, reg_b, reg_c) % 8),
        6 => operand -> reg_b = Int(floor(reg_a/(2^combo_operand(operand, reg_a, reg_b, reg_c)))),
        7 => operand -> reg_c = Int(floor(reg_a/(2^combo_operand(operand, reg_a, reg_b, reg_c))))
    ])
    (reg_a, reg_b, reg_c, memory) = data
    output = Vector{Int}()
    ip = 1
    
    while ip < length(memory)
        instructions[memory[ip]](memory[ip+1])
        ip = ip + 2
    end
    return output
end

function part_one(data::Tuple{Int, Int, Int, Vector{Int}})
    output = run_program(data)
    println(string("Part one: ", join(output, ",")))
end

function solve(reg_a_target::Int, target::Int)
    results = Vector{Int}()
    reg_a_out = reg_a_target << 3
    for a ∈ 0:7
        (reg_a, out) = cycle(reg_a_out + a)
        (out == target && reg_a == reg_a_target) && push!(results, reg_a_out+a)
    end
    return results
end

function part_two(data::Tuple{Int, Int, Int, Vector{Int}})
    memory = data[4]
    reg_a = Vector{Int}()
    que = Vector{Tuple{Int, Int}}()
    push!(que, (0, length(memory)))
    while length(que) > 0
        (a_out, i) = popfirst!(que)
        solutions = solve(a_out, memory[i])
        for s ∈ solutions
            (i > 1) && push!(que, (s, i-1))
            (i == 1) && push!(reg_a, s)
        end
    end
    println("Part Two: $(minimum(reg_a))")
end

#data = read_data("./Day17/test.txt")
#data = read_data("./Day17/test2.txt")
data = read_data("./Day17/data.txt")

part_one(data)
part_two(data)
#solve(0, 4)
#solve(2, 1)
#solve(23, 3)
#solve(191, 0)
#solve(1532, 6)
#solve(12263, 7)
#solve(98107, 4)
#solve(784856, 1)
#solve(6278853, 2)



