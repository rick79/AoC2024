mutable struct Robot
    y::Int
    x::Int
    Δy::Int
    Δx::Int
end

function read_data(path::String)
    robots = Vector{Robot}()
    for line ∈ eachline(path)
        v = parse.(Int, match(r"^p=(\d+),(\d+) v=(-?\d+),(-?\d+)$", line))
        push!(robots, Robot(v[2], v[1], v[4], v[3]))
    end
    return robots
end

function simulate(r::Robot, time::Int, height::Int, width::Int)
    r.y = (r.y + r.Δy * time) % height
    r.x = (r.x + r.Δx * time) % width
    (r.y < 0) && (r.y = r.y + height)
    (r.x < 0) && (r.x = r.x + width)
end

function safety_factor(robots::Vector{Robot}, height::Int, width::Int)
    my = Int(ceil(height/2))
    mx = Int(ceil(width/2))
    m = fill(0, height, width)
    for r ∈ robots
        m[r.y+1, r.x+1] += 1
    end
    return sum(m[1:(my-1), 1:(mx-1)]) * sum(m[1:(my-1), (mx+1):end]) * sum(m[(my+1):end, 1:(mx-1)]) * sum(m[(my+1):end, (mx+1):end])
end

function adjecency_score(robots::Vector{Robot}, height::Int, width::Int)
    m = fill(0, height, width)
    for r ∈ robots
        m[r.y+1, r.x+1] = 1
    end
    a = 0
    for r ∈ robots
        (r.y + 1 > 1 && m[r.y, r.x + 1] == 1) && (a += 1)
        (r.y + 1 < last(axes(m, 1)) && m[r.y + 2, r.x + 1] == 1) && (a += 1)
        (r.x + 1 > 1 && m[r.y + 1, r.x] == 1) && (a += 1)
        (r.x + 1 < last(axes(m, 2)) && m[r.y + 1, r.x + 2] == 1) && (a += 1)
    end
    return a
end

function part_one(robots::Vector{Robot}, height::Int, width::Int)
    robots = deepcopy(robots)    
    for r ∈ robots
        simulate(r, 100, height, width)
    end
    res = safety_factor(robots, height, width)
    @assert res == 222062148
    println("Part One: $res")
end

#=
function part_two(robots::Vector{Robot}, height::Int, width::Int)
    robots = deepcopy(robots)    
    open("result.txt", "w") do file
        for timer ∈ 1:10000
            for r ∈ robots
                simulate(r, 1, height, width)
            end
            write(file, "Time: $timer\n")
            m = fill(0, height, width)
            for r ∈ robots
                m[r.y+1, r.x+1] += 1
            end
            for y ∈ axes(m, 1)
                for x ∈ axes(m, 2)
                    if m[y, x] == 0
                        write(file, ' ')
                    else
                        write(file, string(m[y, x]))
                    end
                end
                write(file, "\n")
            end
        end
    end
end
=#

function part_two(robots::Vector{Robot}, height::Int, width::Int)
    robots = deepcopy(robots)    
    ha = 0
    ht = 0
    for timer ∈ 1:10000
        for r ∈ robots
            simulate(r, 1, height, width)
        end
        a = adjecency_score(robots, height, width)
        if a > ha
            ha = a
            ht = timer
        end
    end
    @assert ht == 7520
    println("Part Two: $ht")
end

data = read_data("./Day14 - Restroom Redoubt/data.txt")
#data = read_data("./Day14 - Restroom Redoubt/test.txt")
@time part_one(data, 103, 101)
@time part_two(data, 103, 101)
