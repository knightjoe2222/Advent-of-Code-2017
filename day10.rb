# initialize list from 0 -> 255
list = (0..255).to_a
# grab input from text file
input = open(ARGV.first).read.strip.split(',')
# puts "#{input}"
# set position to 0
# set skip size to 0
position, skip = 0, 0

# change every value from input into an integer
input.each do |i|
  input[position] = i.to_i
  position += 1
end

#reset position to 0
position = 0

#loop through every length in input
input.each do |length|
  # get a sub-array from position -> position + length
  # checking if it needs wrapping, using modulus
  subarr = []
  length.times do |l|
    subarr.push(list[(position + l) % list.length])
  end
  subarr.reverse!
  # now let's put the subarr back into the main list array
  subarr.each_with_index do |v, i|
    list[(position + i) % list.length] = v
  end
  # increment position by length and the skip size
  position += length + skip
  # due to circular nature, set position to modulus of list.length
  position = position % list.length
  # increment skip size
  skip += 1
end

puts "Part 1 Solution: #{list[0] * list[1]}"
