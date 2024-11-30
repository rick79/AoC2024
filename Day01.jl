#=



=#


function read_data(path::String)
    input = open(path) do file
        read(file, String)
    end
    data = split(input, "\n")
    return data
end

function part_one(data::Any)
    println("Part One: ")
end


function part_two(data::Any) 
    println("Part Two: ")
end



data = read_data("Day01-test.txt")
part_one(data)
part_two(data)



