function read_data(path::String)
    lines = readlines(path)
    return [lines[y][x] for y ∈ eachindex(lines), x ∈ eachindex(lines[1])]
end

function part_one(matrix::Matrix{Char})
    yl = last(axes(matrix, 1))
    xl = last(axes(matrix, 2))
    res = 0
    for y ∈ axes(matrix, 1)
        for x ∈ axes(matrix, 2)
            ((x+3) <= xl && matrix[y, x] == 'X' && matrix[y, x+1] == 'M' && matrix[y, x+2] == 'A' && matrix[y, x+3] == 'S') && (res += 1)
            ((x+3) <= xl && matrix[y, x] == 'S' && matrix[y, x+1] == 'A' && matrix[y, x+2] == 'M' && matrix[y, x+3] == 'X') && (res += 1)
            ((x+3) <= xl && (y+3) <= yl && matrix[y, x] == 'X' && matrix[y+1, x+1] == 'M' && matrix[y+2, x+2] == 'A' && matrix[y+3, x+3] == 'S') && (res += 1)
            ((x+3) <= xl && (y+3) <= yl && matrix[y, x] == 'S' && matrix[y+1, x+1] == 'A' && matrix[y+2, x+2] == 'M' && matrix[y+3, x+3] == 'X') && (res += 1)
            ((y+3) <= yl && matrix[y, x] == 'X' && matrix[y+1, x] == 'M' && matrix[y+2, x] == 'A' && matrix[y+3, x] == 'S') && (res += 1)
            ((y+3) <= yl && matrix[y, x] == 'S' && matrix[y+1, x] == 'A' && matrix[y+2, x] == 'M' && matrix[y+3, x] == 'X') && (res += 1)
            ((x>=4) && (y+3)<=yl && matrix[y, x] == 'X' && matrix[y+1, x-1] == 'M' && matrix[y+2, x-2] == 'A' && matrix[y+3, x-3] == 'S') && (res += 1)
            ((x>=4) && (y+3)<=yl && matrix[y, x] == 'S' && matrix[y+1, x-1] == 'A' && matrix[y+2, x-2] == 'M' && matrix[y+3, x-3] == 'X') && (res += 1)
        end
    end
    @assert res == 2434
    println("Part One: $res")
end

function part_two(matrix::Matrix{Char})
    res = 0
    for y ∈ 1:(last(axes(matrix, 1))-2)
        for x ∈ 1:(last(axes(matrix, 2))-2)
            (matrix[y, x] == 'M' && matrix[y+1, x+1] == 'A' && matrix[y+2, x+2] == 'S' && matrix[y+2, x] == 'M' && matrix[y+1, x+1] == 'A' && matrix[y, x+2] == 'S') && (res += 1)
            (matrix[y, x] == 'M' && matrix[y+1, x+1] == 'A' && matrix[y+2, x+2] == 'S' && matrix[y+2, x] == 'S' && matrix[y+1, x+1] == 'A' && matrix[y, x+2] == 'M') && (res += 1)
            (matrix[y, x] == 'S' && matrix[y+1, x+1] == 'A' && matrix[y+2, x+2] == 'M' && matrix[y+2, x] == 'M' && matrix[y+1, x+1] == 'A' && matrix[y, x+2] == 'S') && (res += 1)
            (matrix[y, x] == 'S' && matrix[y+1, x+1] == 'A' && matrix[y+2, x+2] == 'M' && matrix[y+2, x] == 'S' && matrix[y+1, x+1] == 'A' && matrix[y, x+2] == 'M') && (res += 1)
         end
    end
    @assert res == 1835
    println("Part Two: $res")
end

#data = read_data("./Day04- Ceres Search/test.txt")
data = read_data("./Day04- Ceres Search/data.txt")
@time part_one(data)
@time part_two(data)
