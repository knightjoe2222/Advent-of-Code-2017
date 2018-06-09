# initialize list from 0 -> 255
list = (0..255).to_a
# grab input from text file
input = open(ARGV.first).read.strip.split('')
# set position to 0
# set skip size to 0
position, skip = 0, 0

# converts every value into ascii representation
input.each do |i|
  input[position] = i.ord
  position += 1
end
# append necessary values from problem description
"17,31,73,47,23".split(',').each do |v|
  input << v.to_i
end

#reset position to 0
position = 0

# loop through 64 times, per problem description
64.times do |a|
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
end

# Now that we have our sparse hash, we convert to dense Hash
# I start by initializing some flag/count variables
i, previous, current, xor = 0, 0, 0, 0
# I will store values returned from xoring in the dense array
dense = []
# Loop 256 times
list.length.times do |a|
  # If start of loop, set previous to value and continue
  if i == 0
    previous = list[i]
    i += 1
    next
  end
  # Set current to the current value
  current = list[i]
  # XOR using Ruby's handy '^' symbol and store result in previous
  previous = previous ^ current
  # Increment i
  i += 1
  # If we are at i == 16, push the final XOR value to dense array
  if i % 16 == 0
    dense.push(previous)
    i = 0
    # Shift the array to the left, dropping the 16 values we just used.
    list = list.drop(16)
  end
end

# Now we are ready to convert to the final hex format.
hex = ""
# Loop through each value in dense, convert to text character than use
# Ruby's unpack method to convert to hex representation. Append to hex string
dense.each do |v|
  hex += v.chr.unpack('H*')[0]
end

puts "Solution for Part 2: #{hex}"
