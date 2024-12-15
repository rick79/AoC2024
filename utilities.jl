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

function ci2t(ci::CartesianIndex)
    return !isnothing(ci) ? (ci[1], ci[2]) : nothing
end

function translate(c::Char)
    c == '^' && return (-1, 0)
    c == 'v' && return (1, 0)
    c == '>' && return (0, 1)
    c == '<' && return (0, -1)
    return (0, 0)
end