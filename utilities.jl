function read_matrix(Integer, path::String)
    input = open(path) do file
        read(file, String)
    end
    lines = split(input, "\n")
    grid = zeros(Int64, length(lines), length(first(lines)))
    for y ∈ eachindex(lines)
        for x ∈ eachindex(lines[y])
            grid[y, x] = parse(Int64, lines[y][x])
        end
    end
end

function read_matrix(Char, path::String)
    lines = readlines(path)
    return [lines[y][x] for y ∈ eachindex(lines), x ∈ eachindex(lines[1])]
end



function print_matrix(matrix::Matrix)
    for y ∈ axes(matrix, 1)
        for x ∈ axes(matrix, 2)
            print(matrix[y, x])
        end
        println()
    end
end