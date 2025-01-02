function translate(c::Char)
    c == '^' && return (-1, 0)
    c == 'v' && return (1, 0)
    c == '>' && return (0, 1)
    c == '<' && return (0, -1)
    return (0, 0)
end

function ci2t(ci::CartesianIndex)
    return !isnothing(ci) ? (ci[1], ci[2]) : nothing
end

function read_data(path::String)
    data = split(read(path, String), "\n\n")
    lines = split(data[1], "\n")
    instructions = replace(data[2], "\n" => "")
    return ([lines[y][x] for y ∈ eachindex(lines), x ∈ eachindex(lines[1])], [translate(x) for x ∈ instructions])
end

function scale_data(m::Matrix{Char})
    n = fill('.', last(axes(m, 1)), last(axes(m, 2))*2)
    for y ∈ axes(m, 1)
        for x ∈ axes(m, 2)
            if m[y, x] == '#'
                n[y, x*2-1] = '#'
                n[y, x*2] = '#'
            elseif m[y, x] == 'O'
                n[y, x*2-1] = '['
                n[y, x*2] = ']'
            elseif m[y, x] == '@'
                n[y, x*2-1] = '@'
                n[y, x*2] = '.'
            end
        end
    end
    return n
end

function gps(m::Matrix{Char}, t::Char)
    return [100*(b[1]-1) + b[2]-1 for b ∈ findall(f->f == t, m)]
end

function check_empty(m::Matrix{Char}, y::Int, x::Int, Δy::Int, Δx)
    m[y, x] == '.' && return true
    m[y, x] == 'O' && return check_empty(m, y+Δy, x+Δx, Δy, Δx)
    (abs(Δy) == 1 && x + Δx < last(axes(m, 2)) && m[y, x] == '[') && return check_empty(m, y+Δy, x+Δx, Δy, Δx) && check_empty(m, y+Δy, x+Δx+1, Δy, Δx)
    (abs(Δy) == 1 && x + Δx > 1 && m[y, x] == ']') && return check_empty(m, y+Δy, x+Δx, Δy, Δx) && check_empty(m, y+Δy, x+Δx-1, Δy, Δx)
    (Δx == 1 && x + Δx < last(axes(m, 2)) && m[y, x] == '[') && return check_empty(m, y+Δy, x+2, Δy, Δx)
    (abs(Δx) == 1 && x + Δx > 1 && m[y, x] == ']') && return check_empty(m, y+Δy, x-2, Δy, Δx)
    return false
end

function run(m::Matrix{Char}, instructions::Vector{Tuple{Int, Int}}, y::Int, x::Int)
    for (Δy, Δx) ∈ instructions
        if check_empty(m, y + Δy, x + Δx, Δy, Δx)
            mq = Vector{Tuple{Int, Int}}()
            push!(mq, (y, x))
            while length(mq) > 0
                (py, px) = pop!(mq)
                yy = py + Δy
                xx = px + Δx
                if m[yy, xx] == '.'
                    m[yy, xx] = m[py, px]
                    m[py, px] = '.'
                elseif abs(Δy) == 1 && m[yy, xx] == '['
                    push!(mq, (py, px))
                    push!(mq, (yy, xx))    
                    push!(mq, (yy, xx+1))    
                elseif abs(Δy) == 1 && m[yy, xx] == ']'
                    push!(mq, (py, px))
                    push!(mq, (yy, xx))
                    push!(mq, (yy, xx-1))
                else
                    push!(mq, (py, px))
                    push!(mq, (yy, xx))
                end
            end
            y += Δy
            x += Δx
        end
    end
end

function part_one(m::Matrix{Char}, i::Vector{Tuple{Int, Int}})
    m = copy(m)
    (y, x) = ci2t(findfirst(f->f == '@', m))
    m[y, x] = '.'
    run(m, i, y, x)
    res = sum(gps(m, 'O'))
    @assert res == 1349898
    println("Part One: $res")
end

function part_two(m::Matrix{Char}, i::Vector{Tuple{Int, Int}})
    m = copy(m)
    (y, x) = ci2t(findfirst(f->f == '@', m))
    m[y, x] = '.'
    run(m, i, y, x)
    res = sum(gps(m, '['))
    @assert res == 1376686
    println("Part Two: $res")
end

(wh, instructions) = read_data("./Day15 - Warehouse Woes/data.txt")
wh2 = scale_data(wh)

@time part_one(wh, instructions)
@time part_two(wh2, instructions)