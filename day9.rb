# Rules
# {} represents a group
# <> represents garbage.
# ! tells me to ignore the next character, no matter what.

# Store the entire stream
stream = open(ARGV.first).read.strip.split('')
# used to keep track of scope, stores opening '{' and '<'
openstack = []
# total score, used for part 1.
score = 0
# keeps track of current scope. Increments by 1 every time we open another group
scope = 1
# flags to handle '!' and '<' behavior.
skip = false
garbage = false
# Part 2's solution: total non-canceled characters within the garbage
char_count = 0

# Loop through stream
stream.each do |c|
  # if the skip flag is true, set it back to false and skip the character immediately
  if skip
    skip = false
    next
  end

  # If we find an '!', set skip to true and go to the next iteration
  if c == '!'
    skip = true
    next

  end
  # if there is currently an open garbage, and the character
  # is not a closing garbage, we increment char_count and skip.
  if garbage && c != '>'
    char_count += 1
    next
  end

  # General switch statement for handling '{', '}', '<' and '>'
  case c
  when '{'
    openstack.push(c)
    score += scope
    scope += 1
  when '<'
    openstack.push(c)
    garbage = true
  when '>'
    openstack.pop()
    garbage = false
  when '}'
      openstack.pop()
      scope -= 1
  else
    next
  end
end

puts "Part 1: #{score}"
puts "Part 2: #{char_count}"
