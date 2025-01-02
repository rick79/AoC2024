function read_data(path::String)
    lines = readlines(path)
    return [lines[y][x] for y ∈ eachindex(lines), x ∈ eachindex(lines[1])]
end

function dijkstra(start::CartesianIndex, m::Matrix{Char})
    directions = [CartesianIndex(-1, 0), CartesianIndex(0, 1), CartesianIndex(1, 0), CartesianIndex(0, -1)]
    que = Vector{CartesianIndex}()
    prev = Dict{CartesianIndex, CartesianIndex}()
    dist = Dict{CartesianIndex, Float64}()
    dist[start] = 0.0
    push!(que, start)
    while !isempty(que)
        u = popfirst!(que)
        for Δ ∈ directions
            v = u + Δ
            !checkbounds(Bool,m, v) && continue
            if m[v] != '#'
                alt = get(dist, u, Inf) + 1
                d = get(dist, v, Inf)
                if alt < d
                    dist[v] = alt
                    prev[v] = u
                    push!(que, v)
                end
            end
        end
    end
    return (dist, prev)
end

#=
function get_path(start::CartesianIndex, stop::CartesianIndex, prev::Dict{CartesianIndex, CartesianIndex})
    u = prev[stop]
    S = Vector{CartesianIndex}()
    if haskey(prev, u) || u == start
        while !isnothing(u)
            pushfirst!(S, u)
            u = get(prev, u, nothing)
        end
        push!(S, stop)
    end
    return S
end

function manhattan(pos1::CartesianIndex, pos2::CartesianIndex)
    return abs(pos2[1]-pos1[1]) + abs(pos2[2]-pos1[2])
end=#

function get_path(start::CartesianIndex, stop::CartesianIndex, prev::Dict{CartesianIndex, CartesianIndex})
    u = prev[stop]
    S = Vector{Tuple{Int, Int}}()
    if haskey(prev, u) || u == start
        while !isnothing(u)
            pushfirst!(S, (u[1], u[2]))
            u = get(prev, u, nothing)
        end
        push!(S, (stop[1], stop[2]))
    end
    return S
end

function manhattan(y1::Int, x1::Int, y2::Int, x2::Int)
    return abs(y2-y1) + abs(x2-x1)
end

function part_one(m::Matrix{Char})
    start = findfirst(f->f=='S', m)
    stop = findfirst(f->f=='E', m)
    (_, prev) = dijkstra(start,m)
    path = get_path(start, stop, prev)
    res = sum([i2 - manhattan(y1, x1, y2, x2) >= 100 for (i1, (y1, x1)) ∈ enumerate(path) for (i2, (y2, x2)) ∈ enumerate(path[i1+1:end]) if manhattan(y1, x1, y2, x2) <= 2])
    @assert res == 1375
    println("Part one: $res")
end

function part_two(m::Matrix{Char})
    start = findfirst(f->f=='S', m)
    stop = findfirst(f->f=='E', m)
    (_, prev) = dijkstra(start,m)
    path = get_path(start, stop, prev)
    res = sum([(i2 - manhattan(y1, x1, y2, x2)) >= 100 for (i1, (y1, x1)) ∈ enumerate(path) for (i2, (y2, x2)) ∈ enumerate(path[i1+1:end]) if manhattan(y1, x1, y2, x2) <= 20])
    @assert res == 983054
    println("Part two: $res")
end

#data = read_data("./Day20 - Race Condition/test.txt")
data = read_data("./Day20 - Race Condition/data.txt")

@time part_one(data)
@time part_two(data)
