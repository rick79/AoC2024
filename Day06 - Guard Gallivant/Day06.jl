function read_data(path::String)
    lines = readlines(path)
    return [lines[y][x] for y ∈ eachindex(lines), x ∈ eachindex(lines[1])]
end

function ci2t(ci::CartesianIndex)
    return !isnothing(ci) ? (ci[1], ci[2]) : nothing
end

function walk_the_line(y::Int, x::Int, Δy::Int, Δx::Int, map::Matrix{Char})
    visited = Vector{Tuple{Int, Int}}()
    height = last(axes(map, 1))
    width = last(axes(map, 2))
    while y > 0 && y < height + 1 && x > 0 && x < width + 1
        (y, x) ∉ visited && push!(visited, (y, x))
        if y + Δy > 0 && y + Δy < height + 1 && x + Δx > 0 && x + Δx < width + 1 && map[y + Δy, x + Δx] == '#'
            Δy, Δx = Δx, -Δy
            continue
        end
        y += Δy
        x += Δx  
    end
    return visited
end

function all_over_again(y::Int, x::Int, Δy::Int, Δx::Int, map::Matrix{Char}, obsy::Int, obsx::Int)
    visited = Set{Tuple{Int, Int, Int, Int}}()
    height = last(axes(map, 1))
    width = last(axes(map, 2))
    while y > 0 && y < height + 1 && x > 0 && x < width + 1
        push!(visited, (y, x, Δy, Δx))
        if y + Δy > 0 && y + Δy < height + 1 && x + Δx > 0 && x + Δx < width + 1 && (map[y+Δy, x+Δx] == '#' || (y + Δy == obsy && x + Δx == obsx))
            Δy, Δx = Δx, -Δy
            continue
        end
        y += Δy
        x += Δx  
        (y, x, Δy, Δx) ∈ visited && return true
    end
    return false
end

function part_one(map::Matrix{Char})
    pos = findfirst(f->f=='^', map)
    res = length(walk_the_line(pos[1], pos[2], -1, 0, map))
    @assert res == 4580
    println("Part One: $res")
end

function part_two(map::Matrix{Char})
    (ystart, xstart) = ci2t(findfirst(f->f=='^', map))
    path = walk_the_line(ystart, xstart, -1, 0, map)
    res = 0
    for (y, x) ∈ path[2:end]
        all_over_again(ystart, xstart, -1, 0, map, y, x) && (res += 1)
    end
    @assert res == 1480
    println("Part Two: $res")
end


#data = read_data("./Day06 - Guard Gallivant/test.txt")
data = read_data("./Day06 - Guard Gallivant/data.txt")
@time part_one(data)
@time part_two(data)
