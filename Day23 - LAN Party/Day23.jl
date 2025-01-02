function read_data(path::String)
    edges = Dict{String, Set{String}}()
    for line ∈ readlines(path)
        ft = split(line, "-")
        e = get(edges, ft[1], Set{String}())
        push!(e, ft[2])
        edges[ft[1]] = e
        e = get(edges, ft[2], Set{String}())
        push!(e, ft[1])
        edges[ft[2]] = e
    end
    return edges
end

function has_edge(edges::Dict{String, Set{String}}, from::String, to::String)
    return haskey(edges, from) && to ∈ edges[from]
end

function find_connected_vertices(edges::Dict{String, Set{String}}, v::String)
    return get(edges, v, Set{String})
end

function part_one(edges::Dict{String, Set{String}})
    permutations = Set{Set{String}}()
    vertices = string.(keys(edges))
    for (ia, a) ∈ enumerate(vertices)
        for (ib, b) ∈ enumerate(vertices[ia:end])
            for c ∈ vertices[ib:end]
                if has_edge(edges, a, b) && has_edge(edges, a, c) && has_edge(edges, b, c)
                    push!(permutations, Set([a b c]))
                end
            end
        end
    end
    res = 0
    for p ∈ permutations
        res += sum(any([e[1] == 't' for e ∈ p]))
    end
    @assert res == 1175
    println("Part One: $res")
end

function part_two(edges::Dict{String, Set{String}})
    password = ""
    l = 0
    vertices = string.(keys(edges))
    for v ∈ vertices
        group = Set{String}([v])
        que = Vector{String}()
        for e ∈ edges[v]
            push!(que, e)
        end
        while !isempty(que)
            u = pop!(que)
            if all([has_edge(edges, u, w) for w ∈ group])
                push!(group, u)
            end
        end
        if length(group) > l
            password = join(sort(collect(group)), ",")
            l = length(group)
        end
    end
    @assert password == "bw,dr,du,ha,mm,ov,pj,qh,tz,uv,vq,wq,xw"
    println(password)
end

#data = read_data("./Day23 - LAN Party/test.txt")
data = read_data("./Day23 - LAN Party/data.txt")

@time part_one(data)
@time part_two(data)
