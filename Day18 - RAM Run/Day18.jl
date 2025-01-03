function read_data(path::String)
    res = Vector{Tuple{Int, Int}}()
    for line ∈ readlines(path)
        p = parse.(Int, split(line, ","))
        push!(res, (p[2], p[1]))
    end
    return res
end

function bfs(y::Int, x::Int, height::Int, width::Int, start::Int, snow::Vector{Tuple{Int, Int}})
    directions = [(-1, 0), (0, -1), (0, 1), (1, 0)]
    que = Vector{Tuple{Int64, Int64, Int64, Vector{Tuple{Int, Int}}}}()
    visited = Set{Tuple{Int64, Int64}}()
    push!(que, (y, x, 0, Vector{Tuple{Int, Int}}()))
    while !isempty(que)
        (y, x, d, p) = popfirst!(que)
        push!(p, (y, x))
        (y == height && x == width) && return (d, p)
        for (Δy, Δx)  ∈ directions
            ny = y + Δy
            nx = x + Δx
            (ny  < 0 || ny > height || nx < 0 || nx > width) && continue
            ((ny, nx) ∈ snow[1:start]) && continue
            ((ny, nx) ∈ visited) && continue
            push!(visited, (y + Δy, x + Δx))
            push!(que, (y + Δy, x + Δx, d + 1, copy(p)))
        end
    end
    return nothing
end

function part_one(data::Vector{Tuple{Int, Int}}, test=false)
    height = test ? 6 : 70
    width = test ? 6 : 70
    (d, _) = bfs(0, 0, height, width, test ? 12 : 1024, data)
    @assert d == 294
    println("Part One: $d")
end

function part_two(data::Vector{Tuple{Int, Int}}, test=false)
    height = test ? 6 : 70
    width = test ? 6 : 70
    res = String
    (d, p) = bfs(0, 0, height, width, test ? 12 : 1024, data)
    for i ∈ (test ? 13 : 1025):length(data)
        if data[i] ∈ p
            res = bfs(0, 0, height, width, i, data)
            if isnothing(res)
                res = "$(data[i][2]),$(data[i][1])"
                break
            else
                p = res[2]
            end
        end
    end
    @assert res == "31,22"
    println("Part Two: $res")
end


#data = read_data("./Day18 - RAM Run/test.txt")
data = read_data("./Day18 - RAM Run/data.txt")


@time part_one(data)
@time part_two(data)
