@layers = []
i, j = 0, 0
@char_index = 0
@severity = 0
found = false

open(ARGV.first) do |f|
  f.each_line do |line|
    # create empty array layer
    layer = []
    # assign the index and depth from input
    index, depth = line.strip.split(': ')
    # convert to integer
    index = index.to_i
    depth = depth.to_i
    # create empty array scan. range is going to visually represent
    # the range of the layer
    range = []
    # if there is a missed index, below loop adds the index to layers
    while i < index
      @layers.push([i])
      i += 1
    end
    # add the index to layer. Layer looks like: [0]
    layer.push(index)
    # populate range array to be length of depth. range: [0, 0, 0 ,0]
    while j < depth
      j == 0 ? range.push(1) : range.push(0)
      j += 1
    end
    # reset j and increment i
    j = 0
    i += 1
    # push range into layer. Layer looks like: [0, [0,0,0,0]]
    layer.push(range)
    layer.push('d') if range.length > 0
    # push that whole array into layers.
    @layers.push(layer)
  end
end

def MoveScanners
  # for each layer in layers
  @layers.each do |l|
    # if the layer's length is 1, there's no security so move on
    next if l.length == 1
    # assign the current index of the security (where the 1 is)
    curr = l[1].find_index {|i| i == 1 }
    # set that 1 to 0.
    l[1][curr] = 0
    # if curr is 0, change the direction to d for down
    if curr == 0
      l[2] = 'd'
    # else if the curr is the last element, change direction to u for up
    elsif curr == l[1].length - 1
      l[2] = 'u'
    end
    # If the direction is down, increment the next element. (going to right)
    # if the direction is up, increment the previous element (going to left)
    l[2] == 'd' ? l[1][curr+1] = 1 : l[1][curr-1] = 1
    #puts "Index: #{l[0]} | Direction: #{l[2]} | Curr: #{curr} | Range: #{l[1]}"
  end
end

def MoveCharacter
  # assign the next layer to moving_to
  moving_to = @layers[@char_index]
  # only proceed if the layer has more than 1 element.
  # having one index implies it has no security and we can simply move thru
  if moving_to.length != 1
    # If there is a 1 at the top of the layer, we are caught! increment severity
    if moving_to[1][0] == 1
      # Caught!
      @severity += @char_index * moving_to[1].length
    end
  end
  # After moving to the new layer, increment @char_index by 1
  @char_index += 1
end

# Part 2 instance variables
@characters = []
@delay = 0

class Character
  attr_accessor :index
  def initialize(index)
    @index = index
  end
end

def MoveAllCharactersByOne
  # increment index of every character object in characters
  @characters.map{ |c| c.index += 1 }
  # delete from characters if 'caught' by scanner
  @characters.delete_if { |c| @layers[c.index].length > 1 && @layers[c.index][1][0] == 1; }
end

def SendCharacters
  # create new character and add to characters array
  @characters.push(Character.new(-1))
  # increment character and test to see if caught
  MoveAllCharactersByOne()
  # increment delay time.
  @delay += 1
end

# Now that layers is populated, we need to simulate the scanner's movement
# We're going to loop 88 times, or the amount of layers present.
# This is because for part 1, the character moves one layer per 'picosecond'
t = 0
while !found
  # Part 1 shown in example, the character moves before the scanners
  puts t
  MoveCharacter() if t < @layers.length
  # Part 2
  SendCharacters()
  # method that moves scanners thru corresponding layer
  MoveScanners()
  if @characters.length > 0 && @characters[0].index >= @layers.length - 1
    puts "Found delay. Breaking out of loop."
    break
  end
  t += 1
end

puts "Part 1 - Severity: #{@severity}"
puts "Part 2 - Delay: #{@delay - @layers.length}"
