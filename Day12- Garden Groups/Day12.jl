function read_data(path::String)
    lines = readlines(path)
    return [lines[y][x] for y ∈ eachindex(lines), x ∈ eachindex(lines[1])]
end

#=
function floodfill(starty::Int, startx::Int, grid::Matrix{Char}, replace = '.')
    que = Vector{Tuple{Int, Int}}()
    visited = Set{Tuple{Int, Int}}()
    push!(que, (starty, startx))
    rt = grid[starty, startx]
    perimeter = 0
    area = 0
    h, w = size(grid)
    while length(que) > 0
        (y, x) = pop!(que)
        area += 1
        for (Δy, Δx) ∈ [(-1, 0), (1, 0), (0, -1), (0, 1)]
            if (y+Δy < 1 || y+Δy > h || x+Δx < 1 || x+Δx > w) || (grid[y+Δy, x+Δx] != rt && grid[y+Δy, x+Δx] != replace)
                perimeter += 1
            end
            if y+Δy >= 1 && y+Δy <= h && x+Δx >= 1 && x+Δx <= w && grid[y+Δy, x+Δx] == rt && (y+Δy, x+Δx) ∉ visited
                push!(que, (y+Δy, x+Δx))
                push!(visited, (y+Δy, x+Δx))
            end
        end
        grid[y, x] = replace
    end
    return (area, perimeter)
end 
=#

function floodfill(start::CartesianIndex, grid::Matrix{Char}, replace = '.')
    directions = [CartesianIndex(-1, 0), CartesianIndex(1, 0), CartesianIndex(0, -1), CartesianIndex(0, 1)]
    visited = Set{CartesianIndex}()
    que = [start]
    rt = grid[start]
    perimeter = 0
    area = 0
    while !isempty(que)
        pos = pop!(que)
        area += 1
        for Δ ∈ directions
            npos = pos + Δ
            if !checkbounds(Bool, grid, npos) || (grid[npos] != rt && grid[npos] != replace)
                perimeter += 1
            end
            if checkbounds(Bool, grid, npos) && grid[npos] == rt && npos ∉ visited
                push!(que, npos)
                push!(visited, npos)
            end
        end
        grid[pos] = replace
    end
    return (area, perimeter)
end 

function find_edges(grid::Matrix{Char}, r::Char)
    edges = 0
    for i ∈ 1:4
        @inbounds for y ∈ axes(grid, 1)
            current = '!'
            @inbounds for x ∈ axes(grid, 2)
                if grid[y, x] == r
                   if grid[y, x] != current  && (y == 1 || (grid[y-1, x] != grid[y, x]))
                        edges += 1
                    elseif y > 1 && grid[y-1, x] != grid[y, x] && x > 1 && grid[y-1, x-1] == grid[y, x]
                        edges += 1
                    end
                end
                current = grid[y, x] 
            end
        end
        (i < 4) && (grid = rotr90(grid))
    end
    return edges
end

function part_one(data::Matrix{Char})
    data = copy(data)
    res = 0
    while (pos = findfirst(f->f != '.', data)) !== nothing
        (a, p) = floodfill(pos, data, '#')
        data[findall(f->f == '#', data)] .= '.'
        res += a*p
    end
    @assert res == 1421958
    println("Part One: $res")
end

function part_two(data::Matrix{Char})
    data = copy(data)
    res = 0
    while (pos = findfirst(f->f != '.', data)) !== nothing
        (a, _) = floodfill(pos, data, '#')
        e = find_edges(data, '#')
        data[findall(f->f == '#', data)] .= '.'
        res += a*e
    end
    @assert res == 885394
    println("Part Two: $res")
end


data = read_data("./Day12- Garden Groups/data.txt")
#data = read_data("./Day12- Garden Groups/test.txt")

@time part_one(data)
@time part_two(data)
