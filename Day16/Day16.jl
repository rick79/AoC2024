function read_data(path::String)
    lines = readlines(path)
    return [lines[y][x] for y ∈ eachindex(lines), x ∈ eachindex(lines[1])]
end

function ci2t(ci::CartesianIndex)
    return !isnothing(ci) ? (ci[1], ci[2]) : nothing
end

function weight(f::Int, Δy::Int, Δx::Int)
    (f == 1 && Δy == -1 && Δx == 0) && return 1
    (f == 1 && Δy == 1 && Δx == 0) && return typemax(Int)
    (f == 1 && Δy == 0 && (Δx == -1 || Δx == 1)) && return 1001
    (f == 2 && Δy == 0 && Δx == 1) && return 1
    (f == 2 && Δy == 0 && Δx == -1) && return typemax(Int)
    (f == 2 && (Δy == 1 || Δy == -1) && Δx == 0) && return 1001
    (f == 3 && Δy == 1 && Δx == 0) && return 1
    (f == 3 && Δy == -1 && Δx == 0) && return typemax(Int)
    (f == 3 && Δy == 0 && (Δx == -1 || Δx == 1)) && return 1001
    (f == 4 && Δy == 0 && Δx == -1) && return 1
    (f == 4 && Δy == 0 && Δx == 1) && return typemax(Int)
    (f == 4 && (Δy == 1 || Δy == -1) && Δx == 0) && return 1001
end

function getdir(Δy::Int, Δx::Int)
    (Δy==-1 && Δx == 0) && return 1
    (Δy==0 && Δx == 1) && return 2
    (Δy==1 && Δx == 0) && return 3
    (Δy==0 && Δx == -1) && return 4
end

function prioritypop!(q::Vector{Tuple{Int, Tuple{Int, Int, Int, Vector{Tuple{Int, Int}}}}})
    mp = typemax(Int)
    mt = (0, 0, 0)
    mi = 0
    for (index, (p, t)) ∈ enumerate(q)
        if p < mp
            mp = p
            mt = t
            mi = index
        end
    end
    deleteat!(q, mi)
    return (mp, mt)
end

function dijkstra(y::Int, x::Int, f::Int, m::Matrix{Char})
    dirs = Dict(
        1 => [(-1, 0), (0, -1), (0, 1)], 
        2 => [(-1, 0), (1, 0), (0, 1)], 
        3 => [(1, 0), (0, -1), (0, 1)], 
        4 => [(-1, 0), (1, 0), (0, -1)])
    que = Vector{Tuple{Int, Tuple{Int, Int, Int, Vector{Tuple{Int, Int}}}}}()
    prev = Dict{Tuple{Int, Int, Int}, Vector{Tuple{Int, Int}}}()
    dist = Dict{Tuple{Int, Int, Int}, Float64}()
    paths = Vector{Tuple{Float64, Vector{Tuple{Int, Int}}}}()
    push!(que, (0, (y, x, f, Vector{Tuple{Int, Int}}())))
    while length(que) > 0
        (w, (y, x, f, p)) = prioritypop!(que)
        push!(p, (y, x))
        (m[y, x] == 'E') && push!(paths, (w, p))
        for (Δy, Δx) ∈ dirs[f] 
            if m[y+Δy, x+Δx] != '#'
                u = (y+Δy, x+Δx, getdir(Δy, Δx))
                alt = w + weight(f, Δy, Δx)
                d = get(dist, u, Inf)
                if alt < d
                    dist[u] = alt
                    prev[u] =[(y, x)]
                    push!(que, (alt, (y+Δy, x+Δx, getdir(Δy, Δx), copy(p))))
                elseif alt == d
                    push!(que, (alt, (y+Δy, x+Δx, getdir(Δy, Δx), copy(p))))
                end
            end
        end
    end
    return (dist, paths)
end

function part_one(m::Matrix{Char})
    (ys, xs) = ci2t(findfirst(f->f=='S', m))
    (yd, xd) = ci2t(findfirst(f->f=='E', m))
    (dist, paths) = dijkstra(ys, xs, 2, m)
    d = minimum([get(dist, (yd, xd, d), typemax(Int)) for d ∈ [1, 2, 3, 4]])
    println("Part One: $(Int(d))")
end

function part_two(m::Matrix{Char})
    (ys, xs) = ci2t(findfirst(f->f=='S', m))
    (yd, xd) = ci2t(findfirst(f->f=='E', m))
    (dist, paths) = dijkstra(ys, xs, 2, m)
    d = minimum([get(dist, (yd, xd, d), typemax(Int)) for d ∈ [1, 2, 3, 4]])
    bt = Set{Tuple{Int, Int}}()
    for (dt, path) ∈ paths
        if dt == d
            for t ∈ path
                push!(bt, t)
            end
        end
    end
    println("Part Two: $(length(bt))")
end

data = read_data("./Day16/data.txt")
#data = read_data("./Day16/test.txt")
#data = read_data("./Day16/test2.txt")


@time part_one(data)
@time part_two(data)

