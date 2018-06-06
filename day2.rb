
checksum = 0
max = 0
min = 0
open(ARGV.first) do |f|
    f.each_line do |line|
        line.split(/\t/).each_with_index do |val, i|
          if i == 0
            max = val.to_i
            min = val.to_i
            next
          end
          max = val.to_i if val.to_i > max
          min = val.to_i if val.to_i < min
        end
        checksum += max - min
    end
end
puts checksum
