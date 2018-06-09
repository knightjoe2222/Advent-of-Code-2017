# Create class with attributes for name, weight, children and parent node.
class Tree
  attr_accessor :name, :weight, :children, :parent

  def initialize(name, weight, children, parent)
    @name = name
    @weight = weight
    @children = children
    @parent = parent
  end
end

# I used two structures to hold the trees. The tree_nodes holds all nodes initialized,
# and the nodes hash stores every node's name as the key, and the corresponding tree object as the value.
# I had to use the nodes hash since the input was out of order and I needed a way to store
# every node and it's associated name so I can update tree_nodes after initializing them all.
tree_nodes = []
nodes = {}

# First I loop through the input file, stripping each line of unnecessary formatting and initialize a Tree object
open(ARGV.first) do |f|
  f.each_line do |line|
    temp = line.tr('(),', '').split(' ')
    children = []

    # If there were children listed, I add the name of all children to a children array.
    i = 3
    while i < temp.length
      children.push(temp[i])
      i += 1
    end

    # Initialize each tree node with the name, weight, children array and a HEAD tree node as the parent.
    t = Tree.new(temp[0], temp[1], children, Tree.new("HEAD", 0, [], []))

    # I store the key|value pair of name|tree object in the nodes hash, for future reference
    nodes[temp[0]] = t
    # I push the tree node into the tree_nodes array.
    tree_nodes.push(t)
  end
end

# Loop through all tree_nodes
tree_nodes.each do |t|
  # If there are children present, I needed a way of updating parent and adding the proper object instead of just a name.
  if t.children
    # children will store the node objects instead of just the name strings
    children = []
    # loop through all children in the node
    t.children.each do |c|
      # update the child's parent to the current tree node
      nodes[c].parent = t
      # add the child node to the children array
      children.push(nodes[c])
    end
    # replace the node's children attribute with the updated array, this time containing node objects instead of just strings of the names
    t.children = children
    # update the node's value in the nodes hash
    nodes[t.name] = t
  end
end

head = nil

#let's go through the tree_nodes and grab the head
tree_nodes.each do |t|
  if t.parent.name == "HEAD"
    head = t
  end
end

puts "Bottom Program: #{head.name}"

####################################################################################3
# Part 2
# I am not happy with how I finished part 2. I used my own discernment when looking at the
# output to find the answer, instead of having the program spit it out for me. I will try harder for day 8.

# pre-order traversal
def pre_order(node)
  return [] if node.nil?
  results = []
  results << node.weight
  i = 0
  while i < node.children.length
    results.concat pre_order(node.children[i])
    i += 1
  end
  return results
end

#breadth-first traversal
def breadth_first(node)
  results = []
  queue = []
  return [] if node.nil?
  queue << node
  while !queue.empty?
    next_node = queue.shift
    results << next_node.weight
    i = 0
    while i < next_node.children.length
      queue << next_node.children[i]
      i += 1
    end
  end
  return results
end

# method that uses pre-order traversal to calculate total weight of node + children + children's children...
def CalculateTotalWeight(head)
  results = pre_order(head)
  sum = 0
  results.each do |r|
    sum += r.to_i
  end
  return sum
end

# Now that the correct node is stored in head, we can make use of level-order traversal to solve part 2.

previous = 0
anomaly = head
i = 0
potential = false
potential_c = nil

anomaly.children.each do |c|
  weight = CalculateTotalWeight(c)
  if i == 0
    previous = weight
    i += 1
    next
  else
    if weight != previous && i > 1 && !potential
      puts "Anomaly found at child: #{c.name}", "It weighs #{weight}, while others weigh #{previous}"
      anomaly = c
      break
    elsif weight != previous && i == 1 && !potential
      puts "Potential Anomaly found at child #{c.name}", "It weighs #{weight}, while others weigh #{previous}"
      puts "Will loop once more to identify which child is anomaly."
      potential = true
      potential_c = c
    elsif potential && weight == previous
      puts "Confirmed Anomaly found at child #{potential_c.name}"
      puts "It weighs #{CalculateTotalWeight(potential_c)}, while others weigh #{previous}"
      potential = false
      anomaly = potential_c
      break
    elsif potential && weight != previous
      puts "Confirmed Anomaly found at first child #{anomaly.children.first.name}"
      puts "It weighs #{previous}, while others weigh #{weight}"
      potential = false
      anomaly = anomaly.children.first
      break
    end
  end
end


puts "Now that we have confirmed what subtree the anomaly is in","let's look through the subtrees in the anomaly."

traversed = false
weights = []

def FindAnomaly(weights)
  whash = {}
  weights.each_with_index do |w, i|
    if i == 0
      whash[w] = [i]
    else
      if whash.key?(w)
        whash[w].push(i)
      else
        whash[w] = [i]
      end
    end
  end
  puts whash
  whash.each do |key, value|
    if value.length == 1
      return value.first
    end
  end
  return 420
end

while !traversed
  anomaly.children.each do |c|
    weight = CalculateTotalWeight(c)
    weights.push(weight)
    puts "Child #{c.name}'s total weight: #{weight}"
  end
  anomaly_index = FindAnomaly(weights)
  if anomaly_index != 420
    puts "Anomaly found in child: #{anomaly.children[anomaly_index].name}"
    anomaly = anomaly.children[anomaly_index]
    weights = []
  else
    puts "No Anomaly found. That means we have output the anomaly already. Do some math."
    traversed = true
    break
  end
end
