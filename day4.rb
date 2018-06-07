# A little less than O(n^2 * num_rows) complexity.
# I could have used a trie structure
# so that insert and search complexities are reduced to O(key_length)
# however I didn't feel that was necessary.
num_valid = 0
valid = true

open(ARGV.first) do |f|
    f.each_line do |line|
      row = line.split(' ')
      row.each_with_index do |a, i|
        row.each_with_index do |b, k|
          if a == b && i != k
            valid = false
            break
          end
        end
        break if !valid
      end
      if valid
        num_valid+= 1
      end
      valid = true
    end
end
puts num_valid
