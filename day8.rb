require 'pp'

@r = {}
@instructions = {}
i = 0
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
end

max = 0

@r.each do |key, value|
  max = value if value > max
end

puts max
