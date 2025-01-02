mutable struct ClawMachine
    Δya::Int
    Δxa::Int
    Δyb::Int
    Δxb::Int
    py::Int
    px::Int
end

function read_data(path::String)
    data= read(path, String)
    clawmachines = Vector{ClawMachine}()
    for input ∈ eachsplit(data, "\n\n", keepempty = false)
        a = parse.(Int64, match(r"Button A: X\+(\d+), Y\+(\d+)", input))
        b = parse.(Int64, match(r"Button B: X\+(\d+), Y\+(\d+)", input))
        p = parse.(Int64, match(r"Prize: X=(\d+), Y=(\d+)", input))
        cm = ClawMachine(a[2], a[1], b[2], b[1], p[2], p[1])
        push!(clawmachines, cm)
    end
    return clawmachines
end

function solve(cm::ClawMachine)
    b = (cm.Δxa*cm.py - cm.Δya*cm.px)/(cm.Δyb*cm.Δxa-cm.Δya*cm.Δxb)
    a = (cm.px - b * cm.Δxb) / cm.Δxa
    return Int(isinteger(a) && isinteger(b) ? 3*a+b : 0)
end

function part_one(clawmachines::Vector{ClawMachine})
    res = sum([solve(cm) for cm ∈ clawmachines])
    @assert res == 32026
    println("Part One: $res")
end

function part_two(clawmachines::Vector{ClawMachine})
    res = 0
    for cm ∈ clawmachines
        cm.px += 10000000000000
        cm.py += 10000000000000
        res += solve(cm)
    end
    @assert res == 89013607072065
    println("Part Two: $res")
end


#data = read_data("./Day13 - Claw Contraption/test.txt")
data = read_data("./Day13 - Claw Contraption/data.txt")

@time part_one(data)
@time part_two(data)
