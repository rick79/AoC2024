function read_matrix(path::String)
    input = open(path) do file
        read(file, String)
    end
    lines = split(input, "\n")
    grid = zeros(Int64, length(lines), length(first(lines)))
    for y ∈ eachindex(lines)
        for x ∈ eachindex(lines[y])
            grid[y, x] = parse(Int64, lines[y][x])
        end
    end
end

function read_matrix(path::String)
    lines = readlines(path)
    return [lines[y][x] for y ∈ eachindex(lines), x ∈ eachindex(lines[1])]
end

function print_matrix(matrix::Matrix)
    for y ∈ axes(matrix, 1)
        for x ∈ axes(matrix, 2)
            print(matrix[y, x])
        end
        println()
    end
end

function ci2t(ci::CartesianIndex)
    return !isnothing(ci) ? (ci[1], ci[2]) : nothing
end

function translate(c::Char)
    c == '^' && return (-1, 0)
    c == 'v' && return (1, 0)
    c == '>' && return (0, 1)
    c == '<' && return (0, -1)
    return (0, 0)
end

function dijkstra(y::Int, x::Int, m::Matrix{Char})
    height = last(axes(m, 1))
    width = last(axes(m, 2))
    que = Vector{Tuple{Int, Int}}()
    prev = Dict{Tuple{Int, Int}, Tuple{Int, Int}}()
    dist = Dict{Tuple{Int, Int}, Float64}()
    dist[(y, x)] = 0.0
    push!(que, (y, x))
    while length(que) > 0
        u = popfirst!(que)
        (y, x) = u
        for (Δy, Δx) ∈ [(-1, 0), (0, 1), (1, 0), (0, -1)]
            ((y + Δy)  < 1 || (y + Δy) > height || (x + Δx) < 1 || (x + Δx) > width) && continue
            if m[y+Δy, x+Δx] != '#'
                v = (y+Δy, x+Δx)
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

function get_path(ys::Int, xs::Int, ye::Int, xe::Int, prev::Dict{Tuple{Int, Int}, Tuple{Int, Int}})
    u = prev[(ye, xe)]
    S = Vector{Tuple{Int, Int}}()
    if haskey(prev, u) || u == (ys, xs)
        while !isnothing(u)
            pushfirst!(S, u)
            u = get(prev, u, nothing)
        end
        push!(S, (ye, xe))
    end
    return S
end

function manhattan(y1::Int, x1::Int, y2::Int, x2::Int)
    return abs(y2-y1) + abs(x2-x1)
end