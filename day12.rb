require 'pp'
# Programs hash stores program number as key, and connections as children
programs = {}
# connected is final array of connected programs, queue used for recursion
connected, queue = [], []
# number of groups, for part 2
groups = 0
# initialize programs hash by looping through input file
open(ARGV.first) do |f|
  f.each_line do |line|
    l = line.split(' ')
    name = l[0]
    programs[name] = {}
    programs[name]['connections'] = []
    i = 2
    while i < l.length
      programs[name]['connections'].push(l[i].to_i)
      i += 1
    end
  end
end

# iterators used in loop
i, j = 0, 0

# populate queue with direct connections to program 0
while j < programs['0']['connections'].length
  queue.push(programs['0']['connections'][j].to_s)
  j += 1
end
# once done, push 0 to connected array, and increment groups count
connected.push('0')
groups += 1

# Now do the same thing, just with everything else.
# While there are programs in the queue, loop and find connections
while queue.length > 0
  i = 0
  pro = queue.shift
  # find all new programs in connections and add to queue
  while i < programs[pro]['connections'].length
    test_program = programs[pro]['connections'][i].to_s
    if !connected.include?(test_program) && !queue.include?(test_program)
      queue.push(test_program)
    end
    i += 1
  end
  # Extra check, just in case repeats already present in connected.
  if !connected.include?(pro)
    connected.push(pro)
  end
end

puts "Part 1: #{connected.length}"

# Loop through programs hash, searching for keys not present in connected
programs.each do |key, value|
  if !connected.include?(key)
    # If key was not present, increment groups and repeat loop from earlier.
    groups += 1
    queue.push(key)
    while queue.length > 0
      i = 0
      pro = queue.shift
      while i < programs[pro]['connections'].length
        test_program = programs[pro]['connections'][i].to_s
        if !connected.include?(test_program) && !queue.include?(test_program)
          queue.push(test_program)
        end
        i += 1
      end
      if !connected.include?(pro)
        connected.push(pro)
      end
    end
  end
end

puts "Part 2: #{groups}"
