module Enumerable
  # Your code goes here
  def my_each_with_index
    index = 0
    while index < self.length
      yield self[index], index
      index += 1
    end
    self
  end

  def my_select
    result = Array.new
    for ele in self
      if yield(ele)
        result << ele
      end
    end
    result
  end

  def my_all?
    for ele in self
      return false unless yield(ele)
    end
    true
  end

  def my_any?
    for ele in self
      return true if yield(ele)
    end
    false
  end

  def my_none?
    for ele in self
      return false if yield(ele)
    end
    true
  end

  def my_count
    return self.length unless block_given?

    count = 0
    for ele in self
      count += 1 if yield(ele)
    end
    count
  end

  def my_map
    result = Array.new
    for ele in self
      result << yield(ele)
    end
    result
  end

  def my_inject initial_value
    result = initial_value

    for ele in self
      result = yield(result, ele)
    end

    return result
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    for ele in self
      yield ele
    end
    self
  end
end
