input = open(ARGV.first).read
#input = "1212"
sum = 0

split_input = input.split('')

split_input.each_with_index do |val, i|

  current = val.to_i

  sum += current if current == input[(i+1)%split_input.length].to_i

end

puts sum
