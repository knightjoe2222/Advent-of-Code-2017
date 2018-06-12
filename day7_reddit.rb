h={}
o=[]
$<.map{ |x|
  # Grabs 'program_name (weight)' and assigns to x
  x=~ /^(\S+) \((\d+)\) ?([^>]+> )?/
  # Checks if there's a 3rd argument on that line, '->'.
  # If '->' is present, store the children in l
  # else, give an empty array of children
  l= ($3 ? ($'.strip.split(', ').map(&:to_sym)) : [])
  # updates the program name in h by setting it equal to the weight and array of children
  h[$1.to_sym] = [$2.to_i,l]
  # adds all children to o array
  o += l
}
q={}

# part 1 only
# deletes from h if the entry either does not have any children or is present in array 'o'
# being present in o implies being a child of some parent.
# p h.delete_if{|x,y|
  # !y.any? || o.index(x)
# }

# part 2 here
h.delete_if{|x,y|a,b=y
#p b
 h[x]=q[x]=[a,b,a+b.sum{|x|h[x] ? h[x][0] : q[x][2]}] if b.all?{|x|!h[x] || (!h[x].any?)}}while h.any?
#p h.reject!{|x,y|y[0]!=y[2]&&y[2]!=0}
 q.map{|x,y|a,b,c=y
t=b.map{|x|q[x][2]}
(p x,a,b,c,t,q[x]) if t.uniq.count>1
}
