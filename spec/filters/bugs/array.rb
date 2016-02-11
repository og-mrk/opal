opal_filter "Array" do
  fails "Array#flatten performs respond_to? and method_missing-aware checks when coercing elements to array"
  fails "Array#flatten with a non-Array object in the Array calls #method_missing if defined"
  fails "Array#join raises a NoMethodError if an element does not respond to #to_str, #to_ary, or #to_s"
  fails "Array#partition returns in the left array values for which the block evaluates to true"
  fails "Array#rassoc calls elem == obj on the second element of each contained array"
  fails "Array#rassoc does not check the last element in each contained but speficically the second"
  fails "Array#select returns a new array of elements for which block is true"
  fails "Array#uniq! properly handles recursive arrays"
  fails "Array#zip fills nil when the given enumereator is shorter than self"
  fails "Array.[] can unpack 2 or more nested referenced array"
end
