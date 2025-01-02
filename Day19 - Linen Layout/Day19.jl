function read_data(path::String)
    parts = split(read(path, String), "\n\n")
    patterns = string.(split(parts[1], ", "))
    designs = string.(split(parts[2], "\n"))
    return (patterns, designs)
end

cache = Dict{String, Bool}()
function solve(design::String, patterns::Vector{String})
    haskey(cache, design) && return cache[design]
    isempty(design) && return true
    res = any([solve(design[length(p)+1:end], patterns) for p ∈ patterns if length(p) <= length(design) && design[1:length(p)] == p])
    global cache[design] = res
    return res
end

cache2 = Dict{String, Int}()
function solve2(design::String, patterns::Vector{String})
    haskey(cache2, design) && return cache2[design]
    isempty(design) && return 1
    res = [solve2(design[length(p)+1:end], patterns) for p ∈ patterns if length(p) <= length(design) && design[1:length(p)] == p]
    res = length(res) > 0 ? sum(res) : 0
    global cache2[design] = res
    return res
end

function part_one(patterns::Vector{String}, designs::Vector{String})
    res = sum([solve(d, patterns) for d ∈ designs])
    @assert res == 317
    println("Part one: $res")
end

function part_two(patterns::Vector{String}, designs::Vector{String})
    res = sum([solve2(d, patterns) for d ∈ designs])
    @assert res == 883443544805484
    println("Part two: $res")
end

#(patterns, designs) = read_data("./Day19 - Linen Layout/test.txt")
(patterns, designs) = read_data("./Day19 - Linen Layout/data.txt")

@time part_one(patterns, designs)
@time part_two(patterns, designs)
