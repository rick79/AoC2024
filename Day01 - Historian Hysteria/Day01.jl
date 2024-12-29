function read_data(path::String)
    lhs = Vector{Int64}()
    rhs = Vector{Int64}()
    for line ∈ readlines(path)
        v = split(line, " ", keepempty = false)
        push!(lhs, parse(Int64, first(v)))
        push!(rhs, parse(Int64, last(v)))
    end
    return (lhs, rhs)
end

function part_one(lhs::Vector{Int64}, rhs::Vector{Int64})
    println(string("Part One: ", sum(abs.(sort(rhs) .- sort(lhs)))))
end

function part_two(lhs::Vector{Int64}, rhs::Vector{Int64})
    println(string("Part Two: ", sum(map(l->l * length(findall(r->r == l, rhs)), lhs))))
end

#(lhs, rhs) = read_data("./Day01 - Historian Hysteria/test.txt")
(lhs, rhs) = read_data("./Day01 - Historian Hysteria/data.txt")
@time part_one(lhs, rhs)
@time part_two(lhs, rhs)




