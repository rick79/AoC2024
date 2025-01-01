function read_data(path::String)
    return [parse(Int, x) for x ∈ eachsplit(read(path, String), " ")]
end

#=
function blink(list::Vector{Int}, times::Int)
    for i ∈ 1:times
        newlist = Vector{Int}()
        l = 0
        for e ∈ list
            if e == 0
                push!(newlist, 1)
            elseif (l = floor(log10(e) + 1)) % 2 == 0
                en = Int(floor(e/10^(l/2)))
                push!(newlist, en)
                push!(newlist, e - en*10^(l/2))
            else
                push!(newlist, e *= 2024)
            end
        end
        list = newlist
    end
    return list
end
=#
cache = Dict{Tuple{Int, Int}, Int}()
function blinkr(v::Int, t::Int)
    t == 0 && return 1
    haskey(cache, (v, t)) && return cache[(v, t)]
    l = 0
    list = Vector{Int}()
    if v == 0
        push!(list, 1)
    elseif (l = floor(log10(v) + 1)) % 2 == 0
        e = Int(floor(v/10^(l/2)))
        push!(list, e)
        push!(list, v - e*10^(l/2))
    else
        push!(list, v * 2024)
    end
    result = 0
    for u ∈ list
        result += blinkr(u, t-1)
    end
    cache[(v, t)] = result
    return result
end


function part_one(list::Vector{Int})
    empty!(cache)
    res = 0
    for i ∈ 1:length(list)
        res = res + blinkr(list[i], 25)
    end
    @assert res ==189092
    println("Part One: $res")
end


function part_two(list::Vector{Int})
    empty!(cache)
    res = 0
    for i ∈ 1:length(list)
        res = res + blinkr(list[i], 75)
    end
    @assert res == 224869647102559
    println("Part Two: $res")
end

#data = read_data("./Day11- Plutonian Pebbles/test.txt")
data = read_data("./Day11- Plutonian Pebbles/data.txt")
@time part_one(data)
@time part_two(data)
