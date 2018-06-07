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
  if instructions[i] >= 3
    instructions[i] -= 1
  else
    instructions[i] += 1
  end
  i += jump
  steps += 1
end

puts steps
