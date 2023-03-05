# lets go from bottom-up
# while looping thru array swap elements when num1 > num2
# repeat this loop for arr length times

def bubble_sort(array)
  len = array.length
  while len > 0
    array[0..-2].each_with_index do |_num1, index|
      array[index], array[index + 1] = array[index + 1], array[index] if array[index] > array[index + 1]
    end
    len -= 1
  end
  array
end

p bubble_sort [4, 3, 78, 2, 0, 2]
