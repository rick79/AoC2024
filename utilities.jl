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
    input = open(path) do file
        read(file, String)
    end
    lines = split(input, "\n")
    grid = fill(' ', length(lines), length(lines[1]))
    for y ∈ eachindex(lines)
        for x ∈ eachindex(lines[y])
            grid[y, x] = lines[y][x]
        end
    end
end
