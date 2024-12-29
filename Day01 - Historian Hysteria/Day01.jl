function read_data(path::String)
    lhs = Vector{Int}()
    rhs = Vector{Int}()
    for line ∈ readlines(path)
        v = split(line, " ", keepempty = false)
        push!(lhs, parse(Int, first(v)))
        push!(rhs, parse(Int, last(v)))
    end
    return (lhs, rhs)
end


function part_one(lhs::Vector{Int}, rhs::Vector{Int})
    println(string("Part One: ", sum(abs.(sort(rhs) - sort(lhs)))))
end

function part_two(lhs::Vector{Int}, rhs::Vector{Int})
    println(string("Part Two: ", sum(map(l->l * length(findall(r->r == l, rhs)), lhs))))
end

#(lhs, rhs) = read_data("./Day01 - Historian Hysteria/test.txt")
(lhs, rhs) = read_data("./Day01 - Historian Hysteria/data.txt")
@time part_one(lhs, rhs)
@time part_two(lhs, rhs)




