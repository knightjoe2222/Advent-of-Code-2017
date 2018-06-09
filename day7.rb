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
    # children will store the tree objects instead of just the name strings
    children = []
    # loop through all children in the node with children
    t.children.each do |c|
      # update the child's parent to the current tree node
      nodes[c].parent = t
      # add the child node to the children array
      children.push(nodes[c])
    end
    # replace the tree's children attribute with the updated array, this time containing node objects instead of just strings of the names
    t.children = children
    # update the tree's value in the nodes hash with the updated tree.
    nodes[t.name] = t
  end
end

# Used in part 1 to print out each node's name, weight & parent.
# The node that still has HEAD as its parent is the 'bottom program', or tree head.
# tree_nodes.each do |t|
#  puts "Name: #{t.name} | Weight: #{t.weight} | Parent: #{t.parent.name}"
# end
