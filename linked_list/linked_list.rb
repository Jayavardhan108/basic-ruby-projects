require_relative 'node'

class LinkedList
  attr_accessor :head, :tail
  attr_reader :size

  def initialize head
    @head = head
    @tail = head
    @size = 1
  end

  def append value
    node = Node.new value
    @tail.next_node = node
    @tail = node
    @size += 1
  end

  def prepend value
    node = Node.new value
    node.next_node = @head
    @head = node
    @size += 1
  end

  def at index
    temp = @head
    temp_node = nil
    until temp == nil || index == -1
      temp_node = temp
      temp = temp.next_node
      index -= 1
    end
    temp_node
  end

  def pop
    temp = @head
    return if temp == nil
    until temp.next_node == @tail
      temp = temp.next_node
    end
    temp.next_node = nil
    @size -= 1
  end

  def contains? value
    temp = @head
    until temp == nil
      return true if temp.value == value
      temp = temp.next_node
    end
    false
  end

  def find value
    temp = @head
    index = 0
    until temp == nil
      return index if temp.value == value
      temp = temp.next_node
      index += 1
    end
    nil
  end

  def to_s 
    temp = @head
    until temp == nil
      print "( #{temp.value} ) -> "
      temp = temp.next_node
    end
    print 'nil'
  end
end


linked_list = LinkedList.new(Node.new(5))
puts linked_list.append 100
puts linked_list.prepend 200

puts linked_list.to_s
linked_list.append 10
puts linked_list.to_s
linked_list.prepend 20
puts linked_list.to_s
puts "size ::: #{linked_list.size}"
puts linked_list.to_s
puts "head ::: #{linked_list.head} and value :: #{linked_list.head.value}"
puts linked_list.to_s
puts "tail :::#{linked_list.tail} and value :: #{linked_list.tail.value}"
puts linked_list.to_s
puts "node at index 1 ::: #{linked_list.at 1} and value :: #{linked_list.at(1).value}"
puts linked_list.to_s
linked_list.pop
puts linked_list.to_s
puts "contains 5 ? ::: #{linked_list.contains? 5}"
puts linked_list.to_s
puts "find 100 ? ::: #{linked_list.find 100}"
puts linked_list.to_s


