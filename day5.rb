instructions = []
i = 0
steps = 0
finished = false

open(ARGV.first) do |f|
    f.each_line do |line|
      instructions.push(line.to_i)
    end
end

while !finished
  if i < 0 || i >= instructions.length
    finished = true
    break
  end
  jump = instructions[i]
  instructions[i] += 1
  i += jump
  steps += 1
end

puts steps
