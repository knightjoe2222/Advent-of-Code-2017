# Take input in, split and assign to directions
input = open("text11.txt").read
directions = input.strip.split(',')

# I will manipulate x, y and z in accordance to
# hexagonal grids as described: https://www.redblobgames.com/grids/hexagons/#distances
x = 0
y = 0
z = 0

distances = []

# The increment/decrement rules are described in the article I linked.
directions.each do |d|
  if d == "n"
    y += 1
    z -= 1
  elsif d == "s"
    y -= 1
    z += 1
  elsif d == "ne"
    x += 1
    z -= 1
  elsif d == "sw"
    x -= 1
    z += 1
  elsif d == "nw"
    x -= 1
    y += 1
  elsif d == "se"
    x += 1
    y -= 1
  end
  # Push the shortest path distance from 'home' to new position
  distances.push((x.abs + y.abs + z.abs) / 2)
end
# Part 1 is the distance away at the end of the directions
puts "Part 1: #{(x.abs + y.abs + z.abs) / 2}"
# Part 2 is the maximum distance away during the directions
puts "Part 2: #{dists.max}"
