#=
--- Day 19: Linen Layout ---

Today, The Historians take you up to the hot springs on Gear Island! Very 
suspiciously, absolutely nothing goes wrong as they begin their careful search 
of the vast field of helixes.

Could this finally be your chance to visit the onsen next door? Only one way 
to find out.

After a brief conversation with the reception staff at the onsen front desk, 
you discover that you don't have the right kind of money to pay the admission 
fee. However, before you can leave, the staff get your attention. Apparently, 
they've heard about how you helped at the hot springs, and they're willing to 
make a deal: if you can simply help them arrange their towels, they'll let you 
in for free!

Every towel at this onsen is marked with a pattern of colored stripes. There 
are only a few patterns, but for any particular pattern, the staff can get you 
as many towels with that pattern as you need. Each stripe can be white (w), 
blue (u), black (b), red (r), or green (g). So, a towel with the pattern ggr 
would have a green stripe, a green stripe, and then a red stripe, in that 
order. (You can't reverse a pattern by flipping a towel upside-down, as that 
would cause the onsen logo to face the wrong way.)

The Official Onsen Branding Expert has produced a list of designs - each a 
long sequence of stripe colors - that they would like to be able to display. 
You can use any towels you want, but all of the towels' stripes must exactly 
match the desired design. So, to display the design rgrgr, you could use two 
rg towels and then an r towel, an rgr towel and then a gr towel, or even a 
single massive rgrgr towel (assuming such towel patterns were actually 
available).

To start, collect together all of the available towel patterns and the list of 
desired designs (your puzzle input). For example:

    r, wr, b, g, bwu, rb, gb, br

    brwrr
    bggr
    gbbr
    rrbgbr
    ubwu
    bwurrg
    brgr
    bbrgwb

The first line indicates the available towel patterns; in this example, the 
onsen has unlimited towels with a single red stripe (r), unlimited towels with 
a white stripe and then a red stripe (wr), and so on.

After the blank line, the remaining lines each describe a design the onsen 
would like to be able to display. In this example, the first design (brwrr) 
indicates that the onsen would like to be able to display a black stripe, a 
red stripe, a white stripe, and then two red stripes, in that order.

Not all designs will be possible with the available towels. In the above 
example, the designs are possible or impossible as follows:

    - brwrr can be made with a br towel, then a wr towel, and then finally an 
      r towel.
    - bggr can be made with a b towel, two g towels, and then an r towel.
    - gbbr can be made with a gb towel and then a br towel.
    - rrbgbr can be made with r, rb, g, and br.
    - ubwu is impossible.
    - bwurrg can be made with bwu, r, r, and g.
    - brgr can be made with br, g, and r.
    - bbrgwb is impossible.

In this example, 6 of the eight designs are possible with the available towel 
patterns.

To get into the onsen as soon as possible, consult your list of towel patterns 
and desired designs carefully. How many designs are possible?

Your puzzle answer was 317.

--- Part Two ---

The staff don't really like some of the towel arrangements you came up with. 
To avoid an endless cycle of towel rearrangement, maybe you should just give 
them every possible option.

Here are all of the different ways the above example's designs can be made:

brwrr can be made in two different ways: b, r, wr, r or br, wr, r.

bggr can only be made with b, g, g, and r.

gbbr can be made 4 different ways:

    g, b, b, r
    g, b, br
    gb, b, r
    gb, br

rrbgbr can be made 6 different ways:

    r, r, b, g, b, r
    r, r, b, g, br
    r, r, b, gb, r
    r, rb, g, b, r
    r, rb, g, br
    r, rb, gb, r

bwurrg can only be made with bwu, r, r, and g.

brgr can be made in two different ways: b, r, g, r or br, g, r.

ubwu and bbrgwb are still impossible.

Adding up all of the ways the towels in this example could be arranged into 
the desired designs yields 16 (2 + 1 + 4 + 6 + 1 + 2).

They'll let you into the onsen as soon as you have the list. What do you get 
if you add up the number of different ways you could make each design?

Your puzzle answer was 883443544805484.

Both parts of this puzzle are complete! They provide two gold stars: **
=#

function read_data(path::String)
    parts = split(read(path, String), "\n\n")
    patterns = string.(split(parts[1], ", "))
    designs = string.(split(parts[2], "\n"))
    return (patterns, designs)
end

cache = Dict{String, Bool}()
function solve(design::String, patterns::Vector{String})
    haskey(cache, design) && return cache[design]
    (length(design) == 0) && return true
    res = any([solve(design[length(p)+1:end], patterns) for p ∈ patterns if length(p) <= length(design) && design[1:length(p)] == p])
    global cache[design] = res
    return res
end

cache2 = Dict{String, Int}()
function solve2(design::String, patterns::Vector{String})
    haskey(cache2, design) && return cache2[design]
    (length(design) == 0) && return 1
    res = [solve2(design[length(p)+1:end], patterns) for p ∈ patterns if length(p) <= length(design) && design[1:length(p)] == p]
    res = length(res) > 0 ? sum(res) : 0
    global cache2[design] = res
    return res
end

function part_one(patterns::Vector{String}, designs::Vector{String})
    counter = sum([solve(d, patterns) for d ∈ designs])
    println("Part one: $counter")
end

function part_two(patterns::Vector{String}, designs::Vector{String})
    counter = sum([solve2(d, patterns) for d ∈ designs])
    println("Part two: $counter")
end

#(patterns, designs) = read_data("./Day19/test.txt")
(patterns, designs) = read_data("./Day19/data.txt")

part_one(patterns, designs)
part_two(patterns, designs)
