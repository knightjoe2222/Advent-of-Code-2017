# KnotHash method from day 10
def KnotHash(g)
  input = g.split('')
  position, skip = 0, 0
  list = (0..255).to_a
  input.each do |i|
    input[position] = i.ord
    position += 1
  end
  "17,31,73,47,23".split(',').each do |v|
    input << v.to_i
  end
  position = 0
  64.times do |a|
    input.each do |length|
      subarr = []
      length.times do |l|
        subarr.push(list[(position + l) % list.length])
      end
      subarr.reverse!
      subarr.each_with_index do |v, i|
        list[(position + i) % list.length] = v
      end
      position += length + skip
      position = position % list.length
      skip += 1
    end
  end
  i, previous, current, xor = 0, 0, 0, 0
  dense = []
  list.length.times do |a|
    if i == 0
      previous = list[i]
      i += 1
      next
    end
    current = list[i]
    previous = previous ^ current
    i += 1
    if i % 16 == 0
      dense.push(previous)
      i = 0
      list = list.drop(16)
    end
  end
  hex = ""
  dense.each do |v|
    hex += v.chr.unpack('H*')[0]
  end
  return hex
end
# End KnotHash method



# Start of Day 14 code
keyword = "wenycdww"
keywords, grid_hash = Array.new(128,""), []
# Populate keywords by appending '-0' --> '-127'
keywords.map!.with_index {|x, i| x + keyword + "-#{i}"}
# Knot Hash Algorithm, for each of the 128 keywords.
keywords.each do |g|
  grid_hash.push(KnotHash(g))
end
# convert each hash into a 128 bit binary representation
i = 0
grid_hash.each do |h|
  binary = ""
  h.split('').each do |c|
    # the magic line that converts each character from hex to 4 digit binary
    num = c.hex.to_s(2).rjust(c.size*4, '0')
    binary += num
  end
  grid_hash[i] = binary
  i += 1
end
#now let's count how many squares are used by counting 1's
used, free = 0, 0
grid_hash.each do |h|
  h.split('').each do |b|
    b == '1' ? used += 1 : free += 1
  end
end
puts "Part 1 Solution - used: #{used} | free: #{free}"

# Part 2

regions = 0
