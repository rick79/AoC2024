using Memoization

function read_data(path::String)
    lines = readlines(path)
    return lines
end

function ci2t(ci::CartesianIndex)
    return !isnothing(ci) ? (ci[1], ci[2]) : nothing
end

function print_matrix(matrix::Matrix)
    for y ∈ axes(matrix, 1)
        for x ∈ axes(matrix, 2)
            print(matrix[y, x])
        end
        println()
    end
end

@memoize function dijkstra(c::Char, m::Matrix{Union{Nothing, Char}})
    height = last(axes(m, 1))
    width = last(axes(m, 2))
    (y, x) = ci2t(findfirst(f->f==c, m))
    que = Vector{Tuple{Int, Int, Vector{Char}}}()
    prev = Dict{Char, Char}()
    dist = Dict{Char, Float64}()
    paths = Dict{Char, Vector{Vector{Char}}}() 
    dist[m[y, x]] = 0.0
    push!(que, (y, x, Vector{Char}()))
    while length(que) > 0
        (y, x, p) = popfirst!(que)
        u = m[y, x]
        push!(p, u)
        paths[m[y, x]] = vcat(get(paths, m[y, x], Vector{Vector{Char}}()), [p])
        for (Δy, Δx) ∈ [(-1, 0), (0, 1), (1, 0), (0, -1)]
            ((y + Δy)  < 1 || (y + Δy) > height || (x + Δx) < 1 || (x + Δx) > width) && continue
            if m[y+Δy, x+Δx] !== nothing
                v = m[y+Δy, x+Δx]
                alt = get(dist, u, Inf) + 1
                d = get(dist, v, Inf)
                if alt < d
                    dist[v] = alt
                    prev[v] = u
                    push!(que, (y+Δy, x+Δx, copy(p)))
                elseif alt == d
                    push!(que, (y+Δy, x+Δx, copy(p)))
                end
            end
        end
    end
    return (dist, prev, paths)
end

function get_path(s::Char, e::Char, prev:: Dict{Char, Char})
    u = prev[e]
    S = Vector{Char}()
    if haskey(prev, u) || u == s
        while !isnothing(u)
            pushfirst!(S, u)
            u = get(prev, u, nothing)
        end
        push!(S, e)
    end
    return S
end

function floyd_warshall(m::Matrix{Union{Nothing, Char}})
    dist = Dict{Tuple{Char, Char}, Float16}()
    for u ∈ m
        for v ∈ m
            if !isnothing(u) && !isnothing(v)
                dist[(u, v)] = Inf
            end
        end
    end
    for u ∈ m
        if !isnothing(u)
            dist[(u, u)] = 0
        end
    end
    for u ∈ m
        if !isnothing(u)
            (d, p) = dijkstra(u, m)
            for v ∈ m
                if !isnothing(v)
                    dist[(u, v)] = d[v]
                end
            end
        end
    end
    for k ∈ m
        for i ∈ m
            for j ∈ m
                if !isnothing(k) && !isnothing(i) && !isnothing(j)
                    if dist[(i, j)] > dist[(i, k)] + dist[(k, j)]
                        dist[(i, j)] = dist[(i, k)] + dist[(k, j)]
                    end
                end
            end
        end
    end
    return dist
end




Memoization.empty_cache!(dijkstra)
function part_one(data::Vector{String})
    
    numeric = Matrix{Union{Nothing, Char}}(['7' '8' '9'; '4' '5' '6'; '1' '2' '3'; nothing '0' 'A'])
    direction = Matrix{Union{Nothing, Char}}([nothing '^' 'A'; '<' 'v' '>';])
    num_paths = Dict{Char, Dict{Char, Vector{Vector{Char}}}}()
    dir_paths = Dict{Char, Dict{Char, Vector{Vector{Char}}}}()
    for n ∈ numeric
        if !isnothing(n)
            (dist, prev, paths) = dijkstra(n, numeric)
            num_paths[n] = paths
        end
    end
    for d ∈ direction
        if !isnothing(d)
            (dist, prev, paths) = dijkstra(d, direction)
            dir_paths[d] = paths
        end
    end
    curr_num = 'A'
    
    for code ∈ data
        for c ∈ code
            nc = num_paths[curr_num][c]
            

    


    println("Part one: ")
end


function part_two(data)
    println("Part two: ")
end








#data = read_data("./Day21 - Keypad Conundrum/test.txt")
data = read_data("./Day21 - Keypad Conundrum/data.txt")

@time part_one(data)
@time part_two(data)