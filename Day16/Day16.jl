#=
--- Day 16: Reindeer Maze ---

It's time again for the Reindeer Olympics! This year, the big event is the 
Reindeer Maze, where the Reindeer compete for the lowest score.

You and The Historians arrive to search for the Chief right as the event is 
about to start. It wouldn't hurt to watch a little, right?

The Reindeer start on the Start Tile (marked S) facing East and need to reach 
the End Tile (marked E). They can move forward one tile at a time (increasing 
their score by 1 point), but never into a wall (#). They can also rotate 
clockwise or counterclockwise 90 degrees at a time (increasing their score by 
1000 points).

To figure out the best place to sit, you start by grabbing a map (your puzzle 
input) from a nearby kiosk. For example:

    ###############
    #.......#....E#
    #.#.###.#.###.#
    #.....#.#...#.#
    #.###.#####.#.#
    #.#.#.......#.#
    #.#.#####.###.#
    #...........#.#
    ###.#.#####.#.#
    #...#.....#.#.#
    #.#.#.###.#.#.#
    #.....#...#.#.#
    #.###.#.#.#.#.#
    #S..#.....#...#
    ###############

There are many paths through this maze, but taking any of the best paths would 
incur a score of only 7036. This can be achieved by taking a total of 36 steps 
forward and turning 90 degrees a total of 7 times:


    ###############
    #.......#....E#
    #.#.###.#.###^#
    #.....#.#...#^#
    #.###.#####.#^#
    #.#.#.......#^#
    #.#.#####.###^#
    #..>>>>>>>>v#^#
    ###^#.#####v#^#
    #>>^#.....#v#^#
    #^#.#.###.#v#^#
    #^....#...#v#^#
    #^###.#.#.#v#^#
    #S..#.....#>>^#
    ###############

Here's a second example:

    #################
    #...#...#...#..E#
    #.#.#.#.#.#.#.#.#
    #.#.#.#...#...#.#
    #.#.#.#.###.#.#.#
    #...#.#.#.....#.#
    #.#.#.#.#.#####.#
    #.#...#.#.#.....#
    #.#.#####.#.###.#
    #.#.#.......#...#
    #.#.###.#####.###
    #.#.#...#.....#.#
    #.#.#.#####.###.#
    #.#.#.........#.#
    #.#.#.#########.#
    #S#.............#
    #################

In this maze, the best paths cost 11048 points; following one such path would 
look like this:

    #################
    #...#...#...#..E#
    #.#.#.#.#.#.#.#^#
    #.#.#.#...#...#^#
    #.#.#.#.###.#.#^#
    #>>v#.#.#.....#^#
    #^#v#.#.#.#####^#
    #^#v..#.#.#>>>>^#
    #^#v#####.#^###.#
    #^#v#..>>>>^#...#
    #^#v###^#####.###
    #^#v#>>^#.....#.#
    #^#v#^#####.###.#
    #^#v#^........#.#
    #^#v#^#########.#
    #S#>>^..........#
    #################

Note that the path shown above includes one 90 degree turn as the very first 
move, rotating the Reindeer from facing East to facing North.

Analyze your map carefully. What is the lowest score a Reindeer could possibly 
get?

Your puzzle answer was 133584.

--- Part Two ---

Now that you know what the best paths look like, you can figure out the best 
spot to sit.

Every non-wall tile (S, ., or E) is equipped with places to sit along the 
edges of the tile. While determining which of these tiles would be the best 
spot to sit depends on a whole bunch of factors (how comfortable the seats 
are, how far away the bathrooms are, whether there's a pillar blocking your 
view, etc.), the most important factor is whether the tile is on one of the 
best paths through the maze. If you sit somewhere else, you'd miss all the 
action!

So, you'll need to determine which tiles are part of any best path through the 
maze, including the S and E tiles.

In the first example, there are 45 tiles (marked O) that are part of at least 
one of the various best paths through the maze:

    ###############
    #.......#....O#
    #.#.###.#.###O#
    #.....#.#...#O#
    #.###.#####.#O#
    #.#.#.......#O#
    #.#.#####.###O#
    #..OOOOOOOOO#O#
    ###O#O#####O#O#
    #OOO#O....#O#O#
    #O#O#O###.#O#O#
    #OOOOO#...#O#O#
    #O###.#.#.#O#O#
    #O..#.....#OOO#
    ###############

In the second example, there are 64 tiles that are part of at least one of the 
best paths:

    #################
    #...#...#...#..O#
    #.#.#.#.#.#.#.#O#
    #.#.#.#...#...#O#
    #.#.#.#.###.#.#O#
    #OOO#.#.#.....#O#
    #O#O#.#.#.#####O#
    #O#O..#.#.#OOOOO#
    #O#O#####.#O###O#
    #O#O#..OOOOO#OOO#
    #O#O###O#####O###
    #O#O#OOO#..OOO#.#
    #O#O#O#####O###.#
    #O#O#OOOOOOO..#.#
    #O#O#O#########.#
    #O#OOO..........#
    #################

Analyze your map further. How many tiles are part of at least one of the best 
paths through the maze?

Your puzzle answer was 622.

Both parts of this puzzle are complete! They provide two gold stars: **
=#
function read_data(path::String)
    lines = readlines(path)
    return [lines[y][x] for y ∈ eachindex(lines), x ∈ eachindex(lines[1])]
end

function ci2t(ci::CartesianIndex)
    return !isnothing(ci) ? (ci[1], ci[2]) : nothing
end

function weight(f::Int, Δy::Int, Δx::Int)
    (f == 1 && Δy == -1 && Δx == 0) && return 1
    (f == 1 && Δy == 1 && Δx == 0) && return typemax(Int)
    (f == 1 && Δy == 0 && (Δx == -1 || Δx == 1)) && return 1001
    (f == 2 && Δy == 0 && Δx == 1) && return 1
    (f == 2 && Δy == 0 && Δx == -1) && return typemax(Int)
    (f == 2 && (Δy == 1 || Δy == -1) && Δx == 0) && return 1001
    (f == 3 && Δy == 1 && Δx == 0) && return 1
    (f == 3 && Δy == -1 && Δx == 0) && return typemax(Int)
    (f == 3 && Δy == 0 && (Δx == -1 || Δx == 1)) && return 1001
    (f == 4 && Δy == 0 && Δx == -1) && return 1
    (f == 4 && Δy == 0 && Δx == 1) && return typemax(Int)
    (f == 4 && (Δy == 1 || Δy == -1) && Δx == 0) && return 1001
end

function getdir(Δy::Int, Δx::Int)
    (Δy==-1 && Δx == 0) && return 1
    (Δy==0 && Δx == 1) && return 2
    (Δy==1 && Δx == 0) && return 3
    (Δy==0 && Δx == -1) && return 4
end

function prioritypop!(q::Vector{Tuple{Int, Tuple{Int, Int, Int, Vector{Tuple{Int, Int}}}}})
    mp = typemax(Int)
    mt = (0, 0, 0)
    mi = 0
    for (index, (p, t)) ∈ enumerate(q)
        if p < mp
            mp = p
            mt = t
            mi = index
        end
    end
    deleteat!(q, mi)
    return (mp, mt)
end

function dijkstra(y::Int, x::Int, f::Int, m::Matrix{Char})
    dirs = Dict(
        1 => [(-1, 0), (0, -1), (0, 1)], 
        2 => [(-1, 0), (1, 0), (0, 1)], 
        3 => [(1, 0), (0, -1), (0, 1)], 
        4 => [(-1, 0), (1, 0), (0, -1)])
    que = Vector{Tuple{Int, Tuple{Int, Int, Int, Vector{Tuple{Int, Int}}}}}()
    prev = Dict{Tuple{Int, Int, Int}, Vector{Tuple{Int, Int}}}()
    dist = Dict{Tuple{Int, Int, Int}, Float64}()
    paths = Vector{Tuple{Float64, Vector{Tuple{Int, Int}}}}()
    push!(que, (0, (y, x, f, Vector{Tuple{Int, Int}}())))
    while length(que) > 0
        (w, (y, x, f, p)) = prioritypop!(que)
        push!(p, (y, x))
        (m[y, x] == 'E') && push!(paths, (w, p))
        for (Δy, Δx) ∈ dirs[f] 
            if m[y+Δy, x+Δx] != '#'
                u = (y+Δy, x+Δx, getdir(Δy, Δx))
                alt = w + weight(f, Δy, Δx)
                d = get(dist, u, Inf)
                if alt < d
                    dist[u] = alt
                    prev[u] =[(y, x)]
                    push!(que, (alt, (y+Δy, x+Δx, getdir(Δy, Δx), copy(p))))
                elseif alt == d
                    push!(que, (alt, (y+Δy, x+Δx, getdir(Δy, Δx), copy(p))))
                end
            end
        end
    end
    return (dist, paths)
end

function part_one(m::Matrix{Char})
    (ys, xs) = ci2t(findfirst(f->f=='S', m))
    (yd, xd) = ci2t(findfirst(f->f=='E', m))
    (dist, paths) = dijkstra(ys, xs, 2, m)
    d = minimum([get(dist, (yd, xd, d), typemax(Int)) for d ∈ [1, 2, 3, 4]])
    println("Part One: $(Int(d))")
end

function part_two(m::Matrix{Char})
    (ys, xs) = ci2t(findfirst(f->f=='S', m))
    (yd, xd) = ci2t(findfirst(f->f=='E', m))
    (dist, paths) = dijkstra(ys, xs, 2, m)
    d = minimum([get(dist, (yd, xd, d), typemax(Int)) for d ∈ [1, 2, 3, 4]])
    bt = Set{Tuple{Int, Int}}()
    for (dt, path) ∈ paths
        if dt == d
            for t ∈ path
                push!(bt, t)
            end
        end
    end
    println("Part Two: $(length(bt))")
end

data = read_data("./Day16/data.txt")
#data = read_data("./Day16/test.txt")
#data = read_data("./Day16/test2.txt")


@time part_one(data)
@time part_two(data)

