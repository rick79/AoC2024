function read_data(path::String)
    return [parse.(Int, n) for n ∈ readlines(path)]
end

function next_secret(s::Int)
    s = (s ⊻ (s << 6)) % 16777216
    s = (s ⊻ (s >> 5)) % 16777216
    s = (s ⊻ (s << 11)) % 16777216
    return s
end

function most_bananas(change::Vector{Int}, price::Vector{Int})
    res = Dict{Vector{Int}, Int}()
    for i ∈ 4:2000
        l = reverse([change[i - ii] for ii ∈ 0:3])
        if !haskey(res, l)
            res[l] = price[i]
        end
    end
    return res
end

function part_one(data::Vector{Int})
    res = 0
    for m ∈ data
        for i ∈ 1:2000
            m = next_secret(m)
        end
        res += m
    end
    @assert res == 17262627539
    println("Part One: $res")            
end

function part_two(data::Vector{Int})
    ccl = Vector{Dict{Vector{Int}, Int}}()
    for m ∈ data
        price = [0]
        change = Vector{Int}()
        for i ∈ 1:2000
            p = m % 10
            push!(change,p - price[end])
            push!(price, p)
            m = next_secret(m)
        end
        price = price[2:end]
        push!(ccl, most_bananas(change, price))
    end
    ck = Set{Vector{Int}}()
    for c ∈ ccl
        for k ∈ keys(c)
            push!(ck, k)
        end
    end
    res = maximum([sum([get(c, k, 0) for c ∈ ccl]) for k ∈ ck])
    @assert res == 1986
    println("Part Two: $res")
end

#data = read_data("./Day22 - Monkey Market/test.txt")
#data = read_data("./Day22 - Monkey Market/test2.txt")
data = read_data("./Day22 - Monkey Market/data.txt")
@time part_one(data)
@time part_two(data)
