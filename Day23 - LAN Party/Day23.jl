using Memoization

function read_data(path::String)
    return [Tuple(string.(split(l, "-"))) for l ∈ readlines(path)]
end

struct Edge 
    from::String
    to::String
    dir::Bool
end

struct Graph
    vertices::Set{String}
    edges::Vector{Edge}
end


function make_graph_from_edges(t::Vector{Tuple{String, String}})
    vertices = Set{String}()
    edges = Vector{Edge}()
    for (a, b) ∈ t
        push!(edges, Edge(a, b, false))
        push!(vertices, a)
        push!(vertices, b)
    end
    return Graph(vertices, edges)
end

@memoize function find_edges(G::Graph, from::String)
    return filter(f->f.from == from || f.to == from, G.edges)
end

@memoize function find_edges(G::Graph, from::String, to::String)
    return filter(f->(f.from == from && f.to == to) || (!f.dir && f.from == to  && f.to == from), G.edges)
end

@memoize function has_edge(G::Graph, from::String, to::String)
    return length(filter(f->(f.from == from && f.to == to) || (!f.dir && f.from == to  && f.to == from), G.edges)) > 0
end

@memoize function find_connected_vertices(G::Graph, v::String)
    return vcat([v.to for v ∈ filter(f->f.from == v, G.edges)], [v.from for v ∈ filter(f->f.to == v, G.edges)])
end

function part_one(data::Vector{Tuple{String, String}})
    G = make_graph_from_edges(data)
    permutations = Set{Set{String}}()

    for a ∈ G.vertices
        for b ∈ G.vertices
            for c ∈ G.vertices
                if has_edge(G, a, b) && has_edge(G, a, c) && has_edge(G, b, c)
                    push!(permutations, Set([a b c]))
                end
            end
        end
    end
    res = 0
    for p ∈ permutations
        res += sum(any([e[1] == 't' for e ∈ p]))
    end
    println("Part One: $res")
end

function part_two(data::Vector{Tuple{String, String}})
    G = make_graph_from_edges(data)
    password = ""
    l = 0
    for v ∈ G.vertices
        group = Set{String}([v])
        que = Vector{String}()
        for e ∈ find_edges(G, v)
            push!(que, e.from == v ? e.to : e.from)
        end
        while length(que) > 0
            u = pop!(que)
            if all([has_edge(G, u, w) for w ∈ group])
                push!(group, u)
            end
        end
        if length(group) > l
            password = join(sort(collect(group)), ",")
            l = length(group)
        end
    end
    println(password)
end

Memoization.empty_all_caches!()
data = read_data("./Day23 - LAN Party/data.txt")
#data = read_data("./Day23 - LAN Party/test.txt")
#@time part_one(data)
@time part_two(data)