# parse through input file, split at tabs and place in array
input = open(ARGV.first).read.split(/\t/)
# input = "0\t2\t7\t0".split(/\t/) - example input

# make each value in input array an integer
input.each_with_index do |v, i|
  input[i] = v.to_i
end

# helper method used to create key for combinations hash
def ArrayToString(input)
  text = ""
  input.each do |i|
    text << "#{i} "
  end
  return text
end

# initialize combinations hash to record previous combinations
combinations = {}
combinations[ArrayToString(input)] = 0

# initialize flag for loop, and cycle count
repeat_combo = false
cycles = 0

while !repeat_combo
  # set i to the index in the input where the max value is
  i = input.index(input.max)
  # set max to input[i]
  max = input.max
  # set j = i, I use j to iterate through input
  j = i

  puts "Cycle #{cycles}"
  puts "Block status before redistribution: #{input}"
  puts "Found max #{max} at index #{i}"

  # We loop through the input max + 1 times because when k = 0,
  # we simply set the input to 0 and are not actually spreading the value across yet.
  (max + 1).times do |k|
    if k == 0
      input[j] = 0
    else # if it is not the first iteration, we increment input[j] by 1.
      input[j] += 1
    end
    j += 1
    # if j is outside the scope of the array, reset it to 0. (circular)
    if j > input.length - 1
      j = 0
    end
  end

  # We have finished a successful cycle so increment the counter.
  cycles += 1

  puts "Block status after redistribution: #{input}"
  # If the new array exists in our combinations hash, we have reached an infinite loop and can break.
  # else, we add the new array to our combinations hash and loop again.
  if combinations.key?(ArrayToString(input))
    repeat_combo = true
    puts "Found repeating combination: #{input} after #{cycles} cycles."
    puts "Repeat occurred at cycle \# #{combinations[ArrayToString(input)]}"
  else
    combinations[ArrayToString(input)] = cycles
    puts "Did not find repeating combination. Looping back\n\n"
  end
end
