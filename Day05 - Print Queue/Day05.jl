function read_data(path::String)
    parts = split(read(path, String), "\n\n")
    rules = [Tuple(parse.(Int, split(n, "|"))) for n ∈ eachsplit(parts[1], "\n")]
    updates = [parse.(Int, split(n, ",")) for n ∈ eachsplit(parts[2], "\n")]
    return (updates, rules)
end

function check_rules(page::Int, pages::Vector{Int}, rules::Vector{Tuple{Int, Int}})
    length(unique(pages)) != length(pages) && return false
    index = findfirst(f->f == page, pages)
    fr = filter(f->f[2]==page, rules)
    for r ∈ fr 
        r[1] ∈ pages[index:end] && return false
    end
    fr = filter(f->f[1]==page, rules)
    for r ∈ fr
        r[2] ∈ pages[1:index] && return false
    end
    return true
end

function uglysort(pages::Vector{Int}, rules::Vector{Tuple{Int, Int}})
    sortedpages = Vector{Int}()
    for page ∈ pages
        if length(sortedpages) == 0
            push!(sortedpages, page)
            continue
        end
        for index ∈ 1:(length(sortedpages)+1)
            list = Vector{Int}()
            if index == 1
                list = vcat([page], sortedpages)
            elseif index > length(sortedpages)
                list = vcat(sortedpages, [page])
            else
                list = vcat(sortedpages[1:index-1], [page], sortedpages[index:end])
            end
            if check_rules(page, list, rules)
                sortedpages = list
                break
            end
        end
    end
    return sortedpages
end

function part_one(updates::Vector{Vector{Int}}, rules::Vector{Tuple{Int, Int}})
    res = sum([all([check_rules(page, pages, rules) for page ∈ pages]) ? pages[ceil(Int, length(pages)/2)] : 0 for pages ∈ updates])
    @assert res == 4996
    println("Part One: $res")
end

function part_two(updates::Vector{Vector{Int64}}, rules::Vector{Tuple{Int64, Int64}})
    res = sum([!all([check_rules(page, pages, rules) for page ∈ pages]) ? uglysort(pages, rules)[ceil(Int, length(pages)/2)] : 0 for pages ∈ updates])
    @assert res == 6311
    println("Part Two: $res")
end

#(updates, rules) = read_data("./Day05 - Print Queue/test.txt")
(updates, rules) = read_data("./Day05 - Print Queue/data.txt")
@time part_one(updates, rules)
@time part_two(updates, rules)
