function read_data(path::String)
    res = Vector{Tuple{Int, Int}}()
    for line ∈ readlines(path)
        p = parse.(Int, split(line, ","))
        push!(res, (p[2], p[1]))
    end
    return res
end

function ci2t(ci::CartesianIndex)
    return !isnothing(ci) ? (ci[1], ci[2]) : nothing
end

function bfs(y::Int, x::Int, height::Int, width::Int, start::Int, snow::Vector{Tuple{Int, Int}})
    que = Vector{Tuple{Int64, Int64, Int64, Vector{Tuple{Int, Int}}}}()
    visited = Vector{Tuple{Int64, Int64}}()
    push!(que, (y, x, 0, Vector{Tuple{Int, Int}}()))
    while length(que) > 0
        (y, x, d, p) = popfirst!(que)
        push!(p, (y, x))
        ((y, x) == (height, width)) && return (d, p)
        for (Δy, Δx)  ∈ [(-1, 0), (0, -1), (0, 1), (1, 0)]
            ((y + Δy)  < 0 || (y + Δy) > height || (x + Δx) < 0 || (x + Δx) > width) && continue
            ((y + Δy, x + Δx) ∈ snow[1:start]) && continue
            ((y + Δy, x + Δx) ∈ visited) && continue
            push!(visited, (y + Δy, x + Δx))
            push!(que, (y + Δy, x + Δx, d + 1, copy(p)))
        end
    end
    return nothing
end

function part_one(data::Vector{Tuple{Int, Int}}, test=false)
    height = test ? 6 : 70
    width = test ? 6 : 70
    (d, p) = bfs(0, 0, height, width, test ? 12 : 1024, data)
    println("Part One: $d")
end

function part_two(data::Vector{Tuple{Int, Int}}, test=false)
    height = test ? 6 : 70
    width = test ? 6 : 70
    (d, p) = bfs(0, 0, height, width, test ? 12 : 1024, data)
    for i ∈ (test ? 13 : 1025):length(data)
        if data[i] ∈ p
            res = bfs(0, 0, height, width, i, data)
            if isnothing(res)
                println("Part Two: $(data[i][2]),$(data[i][1])")
                break
            else
                p = res[2]
            end
        end
    end
end


#data = read_data("./Day18/test.txt")
data = read_data("./Day18/data.txt")

@time part_one(data)
@time part_two(data)
