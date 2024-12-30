function read_data(path::String)
    return [[parse(Int, value) for value ∈ split(line, " ", keepempty = false)] for line ∈ readlines(path)]
end

function check(report::Vector{Int})
    resdec = [(abs(report[i] - report[i+1]) >= 1 && abs(report[i] - report[i+1]) <= 3) && report[i] < report[i+1] for i ∈ 1:(length(report)-1)]
    resinc = [(abs(report[i] - report[i+1]) >= 1 && abs(report[i] - report[i+1]) <= 3) && report[i] > report[i+1] for i ∈ 1:(length(report)-1)]
    return prod(resinc) == 1 || prod(resdec) == 1
end

function part_one(reports::Vector{Vector{Int}})
    res = sum([check(report) for report ∈ reports])
    @assert res == 631
    println("Part One: $res")
end

function part_two(reports::Vector{Vector{Int}})
    res = 0
    for report ∈ reports
        if check(report)
            res += 1
        else
            for i ∈ 1:length(report)
                if check(report[1:end .!= i])
                    res += 1
                    break
                end
            end
        end
    end
    @assert res == 665
    println("Part Two: $res")
end

#reports = read_data("./Day02 - Red-Nosed Reports/test.txt")
reports = read_data("./Day02 - Red-Nosed Reports/data.txt")
@time part_one(reports)
@time part_two(reports)
