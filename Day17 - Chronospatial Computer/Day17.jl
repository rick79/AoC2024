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
=#

function cycle(reg_a::Int)
    reg_b = reg_a % 8
    reg_b = reg_b ⊻ 3
    reg_c = reg_a >> reg_b
    reg_a = reg_a >> 3
    reg_b = reg_b ⊻ 4
    reg_b = reg_b ⊻ reg_c
    return (reg_a, reg_b % 8)
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
    res = join(run_program(data), ",")
    @assert res == "2,1,4,7,6,0,3,1,4"
    println("Part one: $res")
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
    res = minimum(reg_a)
    @assert res == 266932601404433
    println("Part Two: $res")
end

#data = read_data("./Day17 - Chronospatial Computer/test.txt")
#data = read_data("./Day17 - Chronospatial Computer/test2.txt")
data = read_data("./Day17 - Chronospatial Computer/data.txt")

@time part_one(data)
@time part_two(data)




