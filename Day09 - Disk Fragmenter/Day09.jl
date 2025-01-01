function read_data(path::String)
    input = read(path, String)
    result = Vector{Tuple{Int, Int, Bool}}()
    id = 0
    for (i, v) ∈ enumerate(input)
        v = parse(Int, v)
        if v > 0
            if i % 2 == 1
                push!(result, (id, v, false))
                id += 1
            else
                push!(result, (-1, v, false))
            end
        end
    end
    return result
end

function checksum(fs::Vector{Tuple{Int, Int, Bool}})
    cs = 0
    i = 0
    for b ∈ fs
        b[1] > 0 && (cs += sum([i:(i + b[2] - 1)...] .* b[1]))
        i += b[2]
    end
    return cs
end


function part_one(fs::Vector{Tuple{Int, Int, Bool}})
    fs = copy(fs)
    running = true
    while running
        fi = findfirst(f->f[1] == -1, fs)
        li = findlast(f->f[1] != -1, fs)
        if isnothing(fi) || fi > li
            running = false
        else
            r = fs[fi][2] - fs[li][2]
            if r == 0
                fs[fi] = fs[li]
                deleteat!(fs, li)
            elseif r > 0
                fs[fi] = fs[li]
                deleteat!(fs, li)
                insert!(fs, fi+1, (-1, r, false))
            elseif r < 0
                fs[fi] = fs[li]
                fs[fi] = (fs[fi][1], fs[fi][2] + r, false)
                fs[li] = (fs[li][1], -r, false)
            end
        end
    end
    res = checksum(fs)
    @assert res == 6384282079460
    println("Part One: $res")
end


function part_two(fs::Vector{Tuple{Int, Int, Bool}})
    fs = copy(fs)
    li = 0
    while  (li = findlast(f->f[1] != -1 && !f[3], fs)) !== nothing
        fi = findfirst(f->f[1]==-1 && f[2] >= fs[li][2], fs)
        if !isnothing(fi) && fi < li
            r = fs[fi][2] - fs[li][2]
            s = fs[li][2]
            fs[fi] = (fs[li][1], fs[li][2], true)
            fs[li] = (-1, s, true)
            r  > 0 && insert!(fs, fi+1, (-1, r, false))
        else
            fs[li] = (fs[li][1], fs[li][2], true)
        end
    end
    res = checksum(fs)
    @assert res == 6408966547049
    println("Part Two: $res")
end

using BenchmarkTools
#data = read_data("./Day09 - Disk Fragmenter/test.txt")
data = read_data("./Day09 - Disk Fragmenter/data.txt")
#@time part_one(data)
#@time part_two(data)

@benchmark part_two(data)