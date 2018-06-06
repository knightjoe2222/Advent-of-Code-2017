sum = 0

#O(n^2 * num_lines) complexity

open(ARGV.first) do |f|
    f.each_line do |line|
        line.split(/\t/).each_with_index do |a, i|
          line.split(/\t/).each_with_index do |b, k|
            if a.to_i % b.to_i == 0 && a.to_i != b.to_i
              sum += a.to_i / b.to_i
              puts "Adding #{a} divided by #{b} to sum"
            end
          end
        end
    end
end
puts sum
