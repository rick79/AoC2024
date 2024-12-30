function read_data(path::String)
    return replace(read(path, String), "\n" => "")
end

function extract_and_mul(data::String)
    return sum([parse(Int, match[1]) * parse(Int, match[2]) for match ∈ eachmatch(r"(?<=mul\()(\d+),(\d+)(?=\))", data)])
end

function part_one(data::String)
    res = extract_and_mul(data)
    @assert res == 188741603
    println("Part One: $res")
end

function part_two(data::String)
    res = sum([extract_and_mul(string(match[1])) for match ∈ eachmatch(r"(?<=do\(\))(.+?)(?=don't\(\))", string("do()", data, "don't()"))])
    @assert res == 67269798
    println("Part Two: $res")
end

#data = read_data("./Day03 - Mull It Over/test.txt")
#data = read_data("./Day03 - Mull It Over/test2.txt")
data = read_data("./Day03 - Mull It Over/data.txt")

@time part_one(data)
@time part_two(data)
