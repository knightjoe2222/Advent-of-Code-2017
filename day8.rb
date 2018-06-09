require 'pp'

# @r: stores registers. Key = register name. Value = register value
@r = {}
# @instructions: stores instructions.
# =>  Key = instruction index (starting at 0)
# =>  Value = hash containing key/value pairs for target, command, change & condition
@instructions = {}

# max stores solution for part 1
max = 0

# @highest_value stores solution for part 2
@highest_value = 0

# iterator
i = 0

# First we loop through each line, initializing key in registers hash
# if not present, and adding that line of instruction to instructions hash
open(ARGV.first) do |f|
  f.each_line do |line|
    l = line.split(' ')
    if !@r.key?(l[0])
      @r[l[0]] = 0
    end
    @instructions[i] = {}
    @instructions[i]['target'] = l[0]
    @instructions[i]['command'] = l[1]
    @instructions[i]['change'] = l[2]
    @instructions[i]['cond'] = "#{l[4]} #{l[5]} #{l[6]}"
    i += 1
  end
end

# Method used to determine if conditional is true or false
# Uses a switch statement to handle all different kind of comparisons
def check_condition(cond)
  condition = cond.split(' ')
  left = condition[0]
  comparison = condition[1]
  right = condition[2].to_i
  ans = false
  case comparison
  when '>'
    @r[left] > right ? ans = true : ans = false
  when '>='
    @r[left] >= right ? ans = true : ans = false
  when '<'
    @r[left] < right ? ans = true : ans = false
  when '<='
    @r[left] <= right ? ans = true : ans = false
  when '=='
    @r[left] == right ? ans = true : ans = false
  when '!='
    @r[left] != right ? ans = true : ans = false
  else
    puts "unhandled comparison"
    return false
  end
  return ans
end

# Loops through all instructions, determines if conditional is true or not
# and changes value in registry.
@instructions.each do |key, value|
  target = value['target']
  change = value['change'].to_i
  case value['command']
  when 'inc'
    if(check_condition(value['cond']))
      @r[target] += change
    end
  when 'dec'
    if(check_condition(value['cond']))
      @r[target] -= change
    end
  else
    puts "unhandled instruction."
  end
  # after every registry is changed, check if it is larger than highest_value
  @highest_value = @r[target] if @r[target] > @highest_value
end


# finds part 1 solution:
@r.each do |key, value|
  max = value if value > max
end

# Print solution to console
puts "Max: #{max}","Highest Value: #{@highest_value}"
