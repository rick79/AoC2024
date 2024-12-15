#=
--- Day 8: Resonant Collinearity ---

You find yourselves on the roof of a top-secret Easter Bunny installation.

While The Historians do their thing, you take a look at the familiar huge 
antenna. Much to your surprise, it seems to have been reconfigured to emit a 
signal that makes people 0.1% more likely to buy Easter Bunny brand Imitation 
Mediocre Chocolate as a Christmas gift! Unthinkable!

Scanning across the city, you find that there are actually many such antennas. 
Each antenna is tuned to a specific frequency indicated by a single lowercase 
letter, uppercase letter, or digit. You create a map (your puzzle input) of 
these antennas. For example:

    ............
    ........0...
    .....0......
    .......0....
    ....0.......
    ......A.....
    ............
    ............
    ........A...
    .........A..
    ............
    ............

The signal only applies its nefarious effect at specific antinodes based on 
the resonant frequencies of the antennas. In particular, an antinode occurs at 
any point that is perfectly in line with two antennas of the same frequency - 
but only when one of the antennas is twice as far away as the other. This 
means that for any pair of antennas with the same frequency, there are two 
antinodes, one on either side of them.

So, for these two antennas with frequency a, they create the two antinodes 
marked with #:

    ..........
    ...#......
    ..........
    ....a.....
    ..........
    .....a....
    ..........
    ......#...
    ..........
    ..........

Adding a third antenna with the same frequency creates several more antinodes. 
It would ideally add four antinodes, but two are off the right side of the 
map, so instead it adds only two:

    ..........
    ...#......
    #.........
    ....a.....
    ........a.
    .....a....
    ..#.......
    ......#...
    ..........
    ..........

Antennas with different frequencies don't create antinodes; A and a count as 
different frequencies. However, antinodes can occur at locations that contain 
antennas. In this diagram, the lone antenna with frequency capital A creates 
no antinodes but has a lowercase-a-frequency antinode at its location:

    ..........
    ...#......
    #.........
    ....a.....
    ........a.
    .....a....
    ..#.......
    ......A...
    ..........
    ..........

The first example has antennas with two different frequencies, so the 
antinodes they create look like this, plus an antinode overlapping the topmost 
A-frequency antenna:

    ......#....#
    ...#....0...
    ....#0....#.
    ..#....0....
    ....0....#..
    .#....A.....
    ...#........
    #......#....
    ........A...
    .........A..
    ..........#.
    ..........#.

Because the topmost A-frequency antenna overlaps with a 0-frequency antinode, 
there are 14 total unique locations that contain an antinode within the bounds 
of the map.

Calculate the impact of the signal. How many unique locations within the 
bounds of the map contain an antinode?

Your puzzle answer was 354.

--- Part Two ---

Watching over your shoulder as you work, one of The Historians asks if you 
took the effects of resonant harmonics into your calculations.

Whoops!

After updating your model, it turns out that an antinode occurs at any grid 
position exactly in line with at least two antennas of the same frequency, 
regardless of distance. This means that some of the new antinodes will occur 
at the position of each antenna (unless that antenna is the only one of its 
frequency).

So, these three T-frequency antennas now create many antinodes:

    T....#....
    ...T......
    .T....#...
    .........#
    ..#.......
    ..........
    ...#......
    ..........
    ....#.....
    ..........

In fact, the three T-frequency antennas are all exactly in line with two 
antennas, so they are all also antinodes! This brings the total number of 
antinodes in the above example to 9.

The original example now has 34 antinodes, including the antinodes that appear 
on every antenna:

    ##....#....#
    .#.#....0...
    ..#.#0....#.
    ..##...0....
    ....0....#..
    .#...#A....#
    ...#..#.....
    #....#.#....
    ..#.....A...
    ....#....A..
    .#........#.
    ...#......##

Calculate the impact of the signal using this updated model. How many unique 
locations within the bounds of the map contain an antinode?

Your puzzle answer was 1263.

Both parts of this puzzle are complete! They provide two gold stars: **
=#

function read_data(path::String)
    lines = readlines(path)
    return [lines[y][x] for y ∈ eachindex(lines), x ∈ eachindex(lines[1])]
end

function find_antinodes_for((y1, x1)::Tuple{Int64, Int64}, (y2, x2)::Tuple{Int64, Int64}, height::Int64, width::Int64, limit::Int64)
    Δy = y2-y1
    Δx = x2-x1
    res = Set{Tuple{Int64, Int64}}()
    if limit > 1
        res = [(y1, x1), (y2, x2)]
    end
    for i ∈ 1:limit
        (ny1, nx1) = (y1 - Δy * i, x1 - Δx * i)
        (ny2, nx2) = (y2 + Δy * i, x2 + Δx * i)
        if ny1 > 0 && ny1 <= height && nx1 > 0 && nx1 <= width
            push!(res, (ny1, nx1))
        end
        if ny2 > 0 && ny2 <= height && nx2 > 0 && nx2 <= width
            push!(res, (ny2, nx2))
        end
    end
    return res
end

function find_all_antinodes(map::Matrix{Char}, limit::Bool)
    targets = ['a':'z'..., 'A':'Z'..., '0':'9'...]
    antennas = [(pos[1], pos[2], map[pos[1], pos[2]]) for pos ∈ findall(f->f ∈ targets, map)]
    height = last(axes(map, 1))
    width = last(axes(map, 2))
    res = Set{Tuple{Int64, Int64}}()
    for (y, x, f) ∈ antennas
        for (ny, nx, nf) ∈ filter(((ny, nx, nf),)->nf == f && ny != y && nx != x, antennas)
            union!(res, find_antinodes_for((y, x), (ny, nx), height, width, limit ? 1 : height+width))
        end
    end
    return res
end

function part_one(map::Matrix{Char})
    res = find_all_antinodes(map, true)
    println("Part One: $(length(res))")
end

function part_two(map::Matrix{Char})
    res = find_all_antinodes(map, false)
    println("Part Two: $(length(res))")
end

#data = read_data("./Day08/test.txt")
data = read_data("./Day08/data.txt")

@time part_one(data)
@time part_two(data)
