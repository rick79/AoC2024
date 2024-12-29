function read_data(path::String)
    return readlines(path)
end

function ci2t(ci::CartesianIndex)
    return !isnothing(ci) ? (ci[1], ci[2]) : nothing
end

function dijkstra(c::Char, m::Matrix{Union{Nothing, Char}})
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

function setup()
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
    return (num_paths, dir_paths)
end

function get_direction(from::Char, to::Char)
    m = (from ∈ ['7' '8' '9' '4' '5' '6' '1' '2' '3' nothing '0' 'A'] && to ∈ ['7' '8' '9' '4' '5' '6' '1' '2' '3' nothing '0' 'A']) ? Matrix{Union{Nothing, Char}}(['7' '8' '9'; '4' '5' '6'; '1' '2' '3'; nothing '0' 'A']) : Matrix{Union{Nothing, Char}}([nothing '^' 'A'; '<' 'v' '>';])
    f = findfirst(f->f==from, m)
    t = findfirst(f->f==to, m)
    return t-f
end

function press(curr::Char, to::Char, dict_paths::Dict{Char, Dict{Char, Vector{Vector{Char}}}})
    curr == to && return (curr, ["A"])
    res = Vector{String}()
    nc = dict_paths[curr][to]
    for n ∈ nc
        path = Vector{Char}()
        for i ∈ 2:last(axes(n, 1))
            d = get_direction(n[i-1], n[i])
            d == CartesianIndex(-1, 0) && push!(path, '^')
            d == CartesianIndex(1, 0) && push!(path, 'v')
            d == CartesianIndex(0, 1) && push!(path, '>')
            d == CartesianIndex(0, -1) && push!(path, '<')
        end
        push!(path, 'A')
        curr = n[end]
        push!(res, join(path, ""))
    end
    return (curr, res)
end

function remote_press(code::String, n::Int, num_paths::Dict{Char, Dict{Char, Vector{Vector{Char}}}}, dir_paths::Dict{Char, Dict{Char, Vector{Vector{Char}}}})
    cache = Dict{String, Int}()
    function rp(code::String, n::Int, isnumeric::Bool)
        n == 0 && return length(code)
        id = string(code, ":", n)
        haskey(cache, id) && return cache[id]
        curr = 'A'
        res = Vector{String}()
        for c ∈ code
            (curr, paths) = press(curr, c, isnumeric ? num_paths : dir_paths)
            if length(res) == 0
                for path ∈ paths
                    push!(res, path)
                end
            else
                newres = Vector{String}()
                for r ∈ res
                    for path ∈ paths
                        push!(newres, string(r, path))
                    end
                end
                res = newres
            end
        end
        minres = Vector{Int}()
        for r ∈ res
            rsum = 0
            inds = findall(f->f=='A', r)
            pi = 1
            for i ∈ inds
                rsum = rsum + rp(r[pi:i], n-1, false)
                pi = i+1
            end
            push!(minres, rsum)
        end
        res = minimum(minres)
        cache[id] = res
        return res
    end
    return rp(code, n, true)
end

function part_one(codes::Vector{String})
    (num_paths, dir_paths) = setup()
    res = 0
    for code ∈ codes
        minlen = remote_press(code, 3, num_paths, dir_paths)
        complexity = parse(Int, code[1:(end-1)]) * minlen
        res += complexity
    end
    @assert res == 152942
    println("Part One: $res")
end

function part_two(codes::Vector{String})
    (num_paths, dir_paths) = setup()
    res = 0
    for code ∈ codes
        minlen = remote_press(code, 26, num_paths, dir_paths)
        complexity = parse(Int, code[1:(end-1)]) * minlen
        res += complexity
    end
    @assert res == 189235298434780
    println("Part Two: $res")
end

#data = read_data("./Day21 - Keypad Conundrum/test.txt")
data = read_data("./Day21 - Keypad Conundrum/data.txt")

@time part_one(data)
@time part_two(data)