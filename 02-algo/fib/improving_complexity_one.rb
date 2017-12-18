def poorly_written_ruby(*arrays)
   combined_array = []
   arrays.each do |array|
     array.each do |value|
       combined_array << value
     end
   end

   sorted_array = [combined_array.delete_at(combined_array.length-1)]

   for val in combined_array
     i = 0
     while i < sorted_array.length
       if val <= sorted_array[i]
         sorted_array.insert(i, val)
         break
       elsif i == sorted_array.length - 1
         sorted_array << val
         break
       end
       i+=1
     end
   end

   # Return the sorted array
   sorted_array
 end

 def codeOptimzed(*arrays)
  combined_array = arrays.map {|array| array} #places arrays into one array list
  combined_array.flatten! #refactors mapped arrays into a single combined array 

  sorted_array = [combined_array.pop]
  sorted_size = sorted_array.length

  for n in combined_array
    i = 0
    while i < sorted_size
      if n <= sorted_array[i]
        sorted_array.insert(i, n)
        break
      elsif i == sorted_size - 1
        sorted_array.insert(i, n)
        break
      end
      i += 1
    end
  end
  sorted_array #returns sorted array 
 end

