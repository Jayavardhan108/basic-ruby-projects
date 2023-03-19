module Recursion
  
  def fibs n
    result = [0,1]
    for i in 2..(n-1)
      result[i] = result[i - 1] + result[i - 2]
    end
    result
  end

  def fibs_rec n, result = [0,1]
    return 0 if n == 1
    return 1 if n == 2
    result << (fibs_rec(n - 1, result) + fibs_rec(n - 2, result)) if result[n - 1] == nil
    result[n - 1]
  end

  def merge_sort(array)
    return array if array.length < 2

    mid = array.length / 2
    left_array = merge_sort(array[0..mid - 1])
    right_array = merge_sort(array[mid..(array.length - 1)])
    merge(left_array, right_array)
  end

  def merge left_array, right_array
    sorted_array = Array.new(left_array.length + right_array.length)
    left = 0
    right = 0
    index = 0
    while left < left_array.length && right < right_array.length
      if left_array[left] < right_array[right]
        sorted_array[index] = left_array[left]
        left += 1
      else
        sorted_array[index] = right_array[right]
        right += 1
      end
      index += 1
    end

    while left < left_array.length
      sorted_array[index] = left_array[left]
      left += 1
      index += 1
    end

    while right < right_array.length
      sorted_array[index] = right_array[right]
      right += 1
      index += 1
    end

    sorted_array
  end
end
