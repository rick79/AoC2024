function read_data(path::String)
    data = read(path, String)
    parts = split(data, "\n\n")
    wires = Dict{String, Bool}()
    instructions = Vector{Tuple{String, String, String, String}}()
    for p ∈ split(parts[1], "\n")
        m = match(r"^([a-z]+[\d]+): ([0-1])$", p)
        wires[m[1]] = parse(Bool, m[2])
    end
    for line ∈ split(parts[2], "\n")

        m = match(r"^([a-z]+[\d]*) (AND|XOR|OR) ([a-z]+[\d]*) -> ([a-z]+[\d]*)$", line)
        push!(instructions, (m[1], m[2], m[3], m[4]))
    end

    return (wires, instructions)
end

function run(wires::Dict{String, Bool}, instructions::Vector{Tuple{String, String, String, String}})
    changed = Set{String}()
    for (k, v) ∈ wires
        push!(changed, k)
    end
    while length(changed) > 0
        newchanged = Set{String}()
        for i ∈ instructions
            if i[1] ∈ changed || i[3] ∈ changed
                if haskey(wires, i[1]) && haskey(wires, i[3])
                    if i[2] == "AND"
                        wires[i[4]] = wires[i[1]] & wires[i[3]]
                        push!(newchanged, i[4])
                    elseif i[2] == "XOR"
                        wires[i[4]] = wires[i[1]] ⊻ wires[i[3]]
                        push!(newchanged, i[4])
                    elseif i[2] == "OR"
                        wires[i[4]] = wires[i[1]] | wires[i[3]]
                        push!(newchanged, i[4])
                    end
                end
            end
        end
        changed = newchanged
    end
    return wires
end



function part_one(wires::Dict{String, Bool}, instructions::Vector{Tuple{String, String, String, String}})
    wires = run(wires, instructions)
    res = evalpoly(2, [wires[w] for w ∈ sort(collect(keys(wires))) if w[1] == 'z']) 
    println("Part One: $res")
end

function print_ins(i::Tuple{String, String, String, String})
    println("$(i[1]) $(i[2]) $(i[3]) -> $(i[4])")
end

function print_tree(e::String, instructions::Vector{Tuple{String, String, String, String}})
    print_ins(instructions[findfirst(f->f[4] == string("z", e), instructions)])
    for i ∈ findall(f->f[1][2:3] == e || f[3][2:3] == e, instructions)
        print_ins(instructions[i])
        for ii ∈ findall(f->f[1] == instructions[i][4] || f[3] == instructions[i][4], instructions)
            print_ins(instructions[ii])
        end
    end
end

function part_two(wires::Dict{String, Bool}, instructions::Vector{Tuple{String, String, String, String}})
    x = evalpoly(2, [wires[w] for w ∈ sort(collect(keys(wires))) if w[1] == 'x'])
    y = evalpoly(2, [wires[w] for w ∈ sort(collect(keys(wires))) if w[1] == 'y'])
    println("x=$x, y=$y")
    w = copy(wires)
    for i ∈ 0:45
        w[string("y", lpad(i, 2, '0'))] = 0
        w[string("x", lpad(i, 2, '0'))] = 0
    end
    faulty = Set{Int}()
    for i ∈ 0:44        
        w[string("x", lpad(i, 2, '0'))] = 1
        res = run(w, instructions)
        if res[string("z", lpad(i, 2, '0'))] == 0
            push!(faulty, i)
        end
        w[string("x", lpad(i, 2, '0'))] = 0

        w[string("y", lpad(i, 2, '0'))] = 1
        res = run(w, instructions)
        if res[string("z", lpad(i, 2, '0'))] == 0
            push!(faulty, i)
        end
        w[string("y", lpad(i, 2, '0'))] = 0
    end
    println("The bits that are faulti are: $(sort(collect(faulty)))")
    # [11, 15, 19, 37]
    #=
          Z
         XOR     C
        /    \  /
      XOR     OR
     /   \   /  \
    X     Y AND  AND
            | |  | \
            X Y  C  XOR
                    | |
                    X Y  
    =#
    print_tree("11", instructions)
    println()
    print_tree("15", instructions)
    println()
    print_tree("19", instructions)
    println()
    print_tree("37", instructions)

    #=
    gkc AND qqw -> z11
    y11 AND x11 -> dpf
    wpd OR dpf -> dtq
    y11 XOR x11 -> gkc
    qqw XOR gkc -> wpd
            |
            v
        wpd, z11
            |
            v
    gkc AND qqw -> wpd
    y11 AND x11 -> dpf
    y11 XOR x11 -> gkc
    qqw XOR gkc -> z11

    skh XOR rkt -> z15
    x15 XOR y15 -> jqf
    jqf OR kjk -> kbq
    x15 AND y15 -> skh
    rkt AND skh -> kjk
            |
            v
        skh, jqf
            |
            v
    skh XOR rkt -> z15
    jqf OR kjk -> kbq
    rkt AND skh -> kjk
    x15 AND y15 -> jqf
    x15 XOR y15 -> skh

    y19 AND x19 -> z19
    x19 XOR y19 -> cmp
    wfc XOR cmp -> mdd
    cmp AND wfc -> pbb
            |
            v
        z19, mdd
            |
            v
    cmp AND wfc -> z19
    wfc XOR cmp -> mdd
    x19 XOR y19 -> cmp
    y19 AND x19 -> pbb

    jgw OR rhh -> z37
    y37 XOR x37 -> wpp
    smt XOR wpp -> wts
    wpp AND smt -> jgw
    y37 AND x37 -> rhh
            |
            v
        wts, z37
            |
            v
    jgw OR rhh -> wts
    smt XOR wpp -> z37
    wpp AND smt -> jgw
    y37 AND x37 -> rhh
    y37 XOR x37 -> wpp
    =#


end

#wires, instructions = read_data("./Day24 - Crossed Wires/test.txt")
#wires, instructions = read_data("./Day24 - Crossed Wires/test2.txt")
#wires, instructions = read_data("./Day24 - Crossed Wires/test3.txt")
wires, instructions = read_data("./Day24 - Crossed Wires/data.txt")

@time part_one(wires, instructions)
part_two(wires, instructions)