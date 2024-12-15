#=
--- Day 14: Restroom Redoubt ---

One of The Historians needs to use the bathroom; fortunately, you know there's 
a bathroom near an unvisited location on their list, and so you're all quickly 
teleported directly to the lobby of Easter Bunny Headquarters.

Unfortunately, EBHQ seems to have "improved" bathroom security again after 
your last visit. The area outside the bathroom is swarming with robots!

To get The Historian safely to the bathroom, you'll need a way to predict 
where the robots will be in the future. Fortunately, they all seem to be 
moving on the tile floor in predictable straight lines.

You make a list (your puzzle input) of all of the robots' current positions 
(p) and velocities (v), one robot per line. For example:

    p=0,4 v=3,-3
    p=6,3 v=-1,-3
    p=10,3 v=-1,2
    p=2,0 v=2,-1
    p=0,0 v=1,3
    p=3,0 v=-2,-2
    p=7,6 v=-1,-3
    p=3,0 v=-1,-2
    p=9,3 v=2,3
    p=7,3 v=-1,2
    p=2,4 v=2,-3
    p=9,5 v=-3,-3

Each robot's position is given as p=x,y where x represents the number of tiles 
the robot is from the left wall and y represents the number of tiles from the 
top wall (when viewed from above). So, a position of p=0,0 means the robot is 
all the way in the top-left corner.

Each robot's velocity is given as v=x,y where x and y are given in tiles per 
second. Positive x means the robot is moving to the right, and positive y 
means the robot is moving down. So, a velocity of v=1,-2 means that each 
second, the robot moves 1 tile to the right and 2 tiles up.

The robots outside the actual bathroom are in a space which is 101 tiles wide 
and 103 tiles tall (when viewed from above). However, in this example, the 
robots are in a space which is only 11 tiles wide and 7 tiles tall.

The robots are good at navigating over/under each other (due to a combination 
of springs, extendable legs, and quadcopters), so they can share the same tile 
and don't interact with each other. Visually, the number of robots on each 
tile in this example looks like this:

    1.12.......
    ...........
    ...........
    ......11.11
    1.1........
    .........1.
    .......1...

These robots have a unique feature for maximum bathroom security: they can 
teleport. When a robot would run into an edge of the space they're in, they 
instead teleport to the other side, effectively wrapping around the edges. 
Here is what robot p=2,4 v=2,-3 does for the first few seconds:

    Initial state:
    ...........
    ...........
    ...........
    ...........
    ..1........
    ...........
    ...........

    After 1 second:
    ...........
    ....1......
    ...........
    ...........
    ...........
    ...........
    ...........

    After 2 seconds:
    ...........
    ...........
    ...........
    ...........
    ...........
    ......1....
    ...........

    After 3 seconds:
    ...........
    ...........
    ........1..
    ...........
    ...........
    ...........
    ...........

    After 4 seconds:
    ...........
    ...........
    ...........
    ...........
    ...........
    ...........
    ..........1

    After 5 seconds:
    ...........
    ...........
    ...........
    .1.........
    ...........
    ...........
    ...........

The Historian can't wait much longer, so you don't have to simulate the robots 
for very long. Where will the robots be after 100 seconds?

In the above example, the number of robots on each tile after 100 seconds has 
elapsed looks like this:

    ......2..1.
    ...........
    1..........
    .11........
    .....1.....
    ...12......
    .1....1....

To determine the safest area, count the number of robots in each quadrant 
after 100 seconds. Robots that are exactly in the middle (horizontally or 
vertically) don't count as being in any quadrant, so the only relevant robots 
are:

    ..... 2..1.
    ..... .....
    1.... .....
            
    ..... .....
    ...12 .....
    .1... 1....

In this example, the quadrants contain 1, 3, 4, and 1 robot. Multiplying these 
together gives a total safety factor of 12.

Predict the motion of the robots in your list within a space which is 101 
tiles wide and 103 tiles tall. What will the safety factor be after exactly 
100 seconds have elapsed?

Your puzzle answer was 222062148.

--- Part Two ---

During the bathroom break, someone notices that these robots seem awfully 
similar to ones built and used at the North Pole. If they're the same type of 
robots, they should have a hard-coded Easter egg: very rarely, most of the 
robots should arrange themselves into a picture of a Christmas tree.

What is the fewest number of seconds that must elapse for the robots to 
display the Easter egg?

Your puzzle answer was 7520.

Both parts of this puzzle are complete! They provide two gold stars: **
=#

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

#=
function print_state(robots::Vector{Robot}, height::Int, width::Int)
    println("State:")
    m = fill(0, height, width)
    for r ∈ robots
        m[r.y+1, r.x+1] += 1
    end
    for y ∈ axes(m, 1)
        for x ∈ axes(m, 2)
            if m[y, x] == 0
                print(".")
            else
                print(m[y, x])
            end
        end
        println()
    end
end
=#

function part_one(robots::Vector{Robot}, height::Int, width::Int)
    robots = deepcopy(robots)    
    for r ∈ robots
        simulate(r, 100, height, width)
    end
    res = safety_factor(robots, height, width)
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
    println("Part Two: $ht")
end

data = read_data("./Day14/data.txt")
#data = read_data("./Day14/test.txt")
@time part_one(data, 103, 101)
@time part_two(data, 103, 101)
