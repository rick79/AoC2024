#=
=#

function read_data(path::String)
    input = open(path) do file
        read(file, String)
    end
    lines = split(input, "\n", keepempty = false)
end


function part_one()
end

function part_two()
end



data = read_data("Day01-test.txt")
#data = read_data("Day01-data.txt")

part_one()
part_two()