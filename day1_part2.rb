input = open(ARGV.first).read
#input = "1212"
sum = 0

split_input = input.split('')
half = split_input.length / 2

split_input.each_with_index do |val, i|

  current = val.to_i

  sum += current if current == input[(i+half)%split_input.length].to_i

end

puts sum
