function read_data(path::String)
    lines = readlines(path)
    return [lines[y][x] for y ∈ eachindex(lines), x ∈ eachindex(lines[1])]
end

function find_antinodes_for((y1, x1)::Tuple{Int, Int}, (y2, x2)::Tuple{Int, Int}, height::Int, width::Int, limit::Int)
    Δy = y2 - y1
    Δx = x2 - x1
    res = Set{Tuple{Int, Int}}()
    limit > 1 &&  (res = [(y1, x1), (y2, x2)])
    for i ∈ 1:limit
        (ny1, nx1) = (y1 - Δy * i, x1 - Δx * i)
        (ny2, nx2) = (y2 + Δy * i, x2 + Δx * i)
        (ny1 > 0 && ny1 <= height && nx1 > 0 && nx1 <= width) && push!(res, (ny1, nx1))
        (ny2 > 0 && ny2 <= height && nx2 > 0 && nx2 <= width) && push!(res, (ny2, nx2))
    end
    return res
end

function find_all_antinodes(map::Matrix{Char}, limit::Bool)
    targets = ['a':'z'..., 'A':'Z'..., '0':'9'...]
    antennas = [(pos[1], pos[2], map[pos[1], pos[2]]) for pos ∈ findall(f->f ∈ targets, map)]
    height = last(axes(map, 1))
    width = last(axes(map, 2))
    res = Set{Tuple{Int, Int}}()
    for (y, x, f) ∈ antennas
        for (ny, nx, nf) ∈ filter(((ny, nx, nf),)->nf == f && ny != y && nx != x, antennas)
            union!(res, find_antinodes_for((y, x), (ny, nx), height, width, limit ? 1 : height + width))
        end
    end
    return res
end

function part_one(map::Matrix{Char})
    res = length(find_all_antinodes(map, true))
    @assert res == 354
    println("Part One: $res")
end

function part_two(map::Matrix{Char})
    res = length(find_all_antinodes(map, false))
    @assert res == 1263
    println("Part Two: $res")
end

#data = read_data("./Day08 - Resonant Collinearity/test.txt")
data = read_data("./Day08 - Resonant Collinearity/data.txt")

@time part_one(data)
@time part_two(data)
