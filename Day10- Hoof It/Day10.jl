function read_data(path::String)
    lines = readlines(path)
    return [lines[y][x] for y ∈ eachindex(lines), x ∈ eachindex(lines[1])]
end

function dfs(map::Matrix{Char}, y::Int, x::Int, unique::Bool)
    que = Vector{Tuple{Int, Int}}()
    push!(que, (y, x))
    reached = Vector{Tuple{Int, Int}}()
    height = last(axes(map, 1))
    width = last(axes(map, 2))
    while  length(que) > 0
        (y, x) = pop!(que)
        if map[y, x] == '9' && (!unique || (y, x) ∉ reached)
            push!(reached, (y, x))
            continue
        end
        for (Δy, Δx) ∈ [(-1, 0), (1, 0), (0, -1), (0, 1)]
            (y + Δy >= 1 && y + Δy <= height && 
             x + Δx >= 1 && x + Δx <= width && 
             (map[y + Δy, x + Δx] - map[y, x]) == 1) && push!(que, (y + Δy, x + Δx))
        end
    end
    return reached
end

function part_one(map::Matrix{Char})
    trailheads = [(ci[1], ci[2]) for ci ∈ findall(f->f == '0', map)]
    score = length(vcat([dfs(map, y, x, true) for (y, x) ∈ trailheads]...))
    @assert score == 825
    println("Part One: $score")
end

function part_two(map::Matrix{Char})
    trailheads = [(ci[1], ci[2]) for ci ∈ findall(f->f == '0', map)]
    score = length(vcat([dfs(map, y, x, false) for (y, x) ∈ trailheads]...))
    @assert score == 1805
    println("Part Two: $score")
end

#data = read_data("./Day10- Hoof It/test.txt")
data = read_data("./Day10- Hoof It/data.txt")
@time part_one(data)
@time part_two(data)
