function read_data(path::String)
    return [Tuple(string.(split(l, "-"))) for l ∈ readlines(path)]
end

struct Edge 
    from::String
    to::String
end

struct Graph
    vertices::Set{String}
    edges::Vector{Edge}
end


function make_graph_from_edges(t::Vector{Tuple{String, String}})
    vertices = Set{String}()
    edges = Vector{Edge}()
    for (a, b) ∈ t
        push!(edges, Edge(a, b))
        push!(vertices, a)
        push!(vertices, b)
    end
    return Graph(vertices, edges)
end


function part_one(data::Vector{Tuple{String, String}})
    G = make_graph_from_edges(data)
    groups = Vector{Set{String}}()
    for v ∈ G.vertices
        edges = filter(f->f.from == v || f.to == v, G.edges)
        println(edges)
    end
end



#data = read_data("./Day23 - LAN Party/data.txt")
data = read_data("./Day23 - LAN Party/test.txt")
part_one(data)