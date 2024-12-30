function read_data(path::String)
    return [(parse(Int, line[1:(first(findfirst(":", line))-1)]), parse.(Int, split(line[(first(findfirst(":", line))+1):end], " ", keepempty=false))) for line ∈ readlines(path)]
end

solver(operands::Vector{Int}, target::Int, operators::Vector{Function}) = solver(operands[2:end], target, operators::Vector{Function}, operands[1])
function solver(operands::Vector{Int}, target::Int, operators::Vector{Function}, result::Int)
    result > target && return 0
    length(operands) == 0 && return result
    return vcat([solver(operands[2:end], target, operators, f(result, operands[1])) for f in operators]...)
end

function part_one(data::Vector{Tuple{Int, Vector{Int}}})
    functions = [(a, b) -> a + b, (a, b) -> a * b]
    res = sum([equation[1] ∈ solver(equation[2], equation[1], functions) ? equation[1] : 0 for equation in data])
    @assert res == 2501605301465
    println("Part One: $res")
end

function part_two(data::Vector{Tuple{Int, Vector{Int}}})
    functions = [(a, b) -> a + b, (a, b) -> a * b, (a, b)-> (10^floor(Int, log10(b) + 1)) * a + b]
    res = sum([equation[1] ∈ solver(equation[2], equation[1], functions) ? equation[1] : 0 for equation in data])
    @assert res == 44841372855953
    println("Part Two: $res")
end

#data = read_data("./Day07 - Bridge Repair/test.txt")
data = read_data("./Day07 - Bridge Repair/data.txt")

@time part_one(data)
@time part_two(data)

