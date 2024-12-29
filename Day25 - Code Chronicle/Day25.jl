function read_data(path::String)
    keys = Set{Vector{Int}}()
    locks = Set{Vector{Int}}()
    data = read(path, String)
    schematics = split(data, "\n\n")
    height = 0
    for schema ∈ schematics
        lines = split(schema, "\n")
        m = [lines[y][x] for y ∈ eachindex(lines), x ∈ eachindex(lines[1])]
        pattern = [count(f->f=='#', m[1:end, x])-1 for x ∈ axes(m, 2)]
        all([i == '#' for i ∈ lines[1]]) && all([i == '.' for i ∈ lines[end]]) && push!(locks, pattern)
        all([i == '#' for i ∈ lines[end]]) && all([i == '.' for i ∈ lines[1]]) && push!(keys, pattern)
        height = last(axes(m, 1))-2
    end
    return (height, collect(keys), collect(locks))
end


function part_one(height::Int, keys::Vector{Vector{Int}}, locks::Vector{Vector{Int}})
    counter = 0
    for lock ∈ locks
        for key ∈ keys
            all(f->f<=0 , ((lock+key) .- height)) && (counter += 1)
        end
    end
    @assert counter == 2900
    println("Part One: $counter")
end

#(h, k, l) = read_data("./Day25 - Code Chronicle/test.txt")
(h, k, l) = read_data("./Day25 - Code Chronicle/data.txt")

@time part_one(h, k, l)

