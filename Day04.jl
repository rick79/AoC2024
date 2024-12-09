#=
--- Day 4: Ceres Search ---

"Looks like the Chief's not here. Next!" One of The Historians pulls out a 
device and pushes the only button on it. After a brief flash, you recognize 
the interior of the Ceres monitoring station!

As the search for the Chief continues, a small Elf who lives on the station 
tugs on your shirt; she'd like to know if you could help her with her word 
search (your puzzle input). She only has to find one word: XMAS.

This word search allows words to be horizontal, vertical, diagonal, written 
backwards, or even overlapping other words. It's a little unusual, though, as 
you don't merely need to find one instance of XMAS - you need to find all of 
them. Here are a few ways XMAS might appear, where irrelevant characters have 
been replaced with .:

    ..X...
    .SAMX.
    .A..A.
    XMAS.S
    .X....

The actual word search will be full of letters instead. For example:

    MMMSXXMASM
    MSAMXMSMSA
    AMXSXMAAMM
    MSAMASMSMX
    XMASAMXAMM
    XXAMMXXAMA
    SMSMSASXSS
    SAXAMASAAA
    MAMMMXMMMM
    MXMXAXMASX

In this word search, XMAS occurs a total of 18 times; here's the same word 
search again, but where letters not involved in any XMAS have been replaced 
with .:

    ....XXMAS.
    .SAMXMS...
    ...S..A...
    ..A.A.MS.X
    XMASAMX.MM
    X.....XA.A
    S.S.S.S.SS
    .A.A.A.A.A
    ..M.M.M.MM
    .X.X.XMASX

Take a look at the little Elf's word search. How many times does XMAS appear?

Your puzzle answer was 2434.


--- Part Two ---

The Elf looks quizzically at you. Did you misunderstand the assignment?

Looking for the instructions, you flip over the word search to find that this 
isn't actually an XMAS puzzle; it's an X-MAS puzzle in which you're supposed 
to find two MAS in the shape of an X. One way to achieve that is like this:

    M.S
    .A.
    M.S

Irrelevant characters have again been replaced with . in the above diagram. 
Within the X, each MAS can be written forwards or backwards.

Here's the same example from before, but this time all of the X-MASes have 
been kept instead:

    .M.S......
    ..A..MSMS.
    .M.S.MAA..
    ..A.ASMSM.
    .M.S.M....
    ..........
    S.S.S.S.S.
    .A.A.A.A..
    M.M.M.M.M.
    ..........

In this example, an X-MAS appears 9 times.

Flip the word search from the instructions back over to the word search side 
and try again. How many times does an X-MAS appear?

Your puzzle answer was 1835.

Both parts of this puzzle are complete! They provide two gold stars: **
=#

function read_data(path::String)
    lines = readlines(path)
    return [lines[y][x] for y ∈ eachindex(lines), x ∈ eachindex(lines[1])]
end

function part_one(matrix::Matrix{Char})
    yl = last(axes(matrix, 1))
    xl = last(axes(matrix, 2))
    counter = 0
    for y ∈ axes(matrix, 1)
        for x ∈ axes(matrix, 2)
            ((x+3) <= xl && matrix[y, x] == 'X' && matrix[y, x+1] == 'M' && matrix[y, x+2] == 'A' && matrix[y, x+3] == 'S') && begin counter += 1 end
            ((x+3) <= xl && matrix[y, x] == 'S' && matrix[y, x+1] == 'A' && matrix[y, x+2] == 'M' && matrix[y, x+3] == 'X') && begin counter += 1 end
            ((x+3) <= xl && (y+3) <= yl && matrix[y, x] == 'X' && matrix[y+1, x+1] == 'M' && matrix[y+2, x+2] == 'A' && matrix[y+3, x+3] == 'S') && begin counter += 1 end
            ((x+3) <= xl && (y+3) <= yl && matrix[y, x] == 'S' && matrix[y+1, x+1] == 'A' && matrix[y+2, x+2] == 'M' && matrix[y+3, x+3] == 'X') && begin counter += 1 end
            ((y+3) <= yl && matrix[y, x] == 'X' && matrix[y+1, x] == 'M' && matrix[y+2, x] == 'A' && matrix[y+3, x] == 'S') && begin  counter += 1 end
            ((y+3) <= yl && matrix[y, x] == 'S' && matrix[y+1, x] == 'A' && matrix[y+2, x] == 'M' && matrix[y+3, x] == 'X') && begin  counter += 1 end            
            ((x>=4) && (y+3)<=yl && matrix[y, x] == 'X' && matrix[y+1, x-1] == 'M' && matrix[y+2, x-2] == 'A' && matrix[y+3, x-3] == 'S') && begin counter += 1 end                
            ((x>=4) && (y+3)<=yl && matrix[y, x] == 'S' && matrix[y+1, x-1] == 'A' && matrix[y+2, x-2] == 'M' && matrix[y+3, x-3] == 'X') && begin counter += 1 end
        end
    end
    println(string("Part One: ", counter))
end

function part_two(matrix::Matrix{Char})
    counter = 0
    for y ∈ 1:(last(axes(matrix, 1))-2)
        for x ∈ 1:(last(axes(matrix, 2))-2)
            (matrix[y, x] == 'M' && matrix[y+1, x+1] == 'A' && matrix[y+2, x+2] == 'S' && matrix[y+2, x] == 'M' && matrix[y+1, x+1] == 'A' && matrix[y, x+2] == 'S') && begin counter += 1 end
            (matrix[y, x] == 'M' && matrix[y+1, x+1] == 'A' && matrix[y+2, x+2] == 'S' && matrix[y+2, x] == 'S' && matrix[y+1, x+1] == 'A' && matrix[y, x+2] == 'M') && begin counter += 1 end
            (matrix[y, x] == 'S' && matrix[y+1, x+1] == 'A' && matrix[y+2, x+2] == 'M' && matrix[y+2, x] == 'M' && matrix[y+1, x+1] == 'A' && matrix[y, x+2] == 'S') && begin counter += 1 end
            (matrix[y, x] == 'S' && matrix[y+1, x+1] == 'A' && matrix[y+2, x+2] == 'M' && matrix[y+2, x] == 'S' && matrix[y+1, x+1] == 'A' && matrix[y, x+2] == 'M') && begin counter += 1 end
         end
    end
    println(string("Part Two: ", counter))
end


#data = read_data("Day04-test.txt")
data = read_data("Day04-data.txt")
@time part_one(data)
@time part_two(data)