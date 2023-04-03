require_relative 'node'
require 'pry-byebug'

# This is Tree Class
class Tree
  attr_accessor :array, :root

  def initialize(array)
    @array = array
    sorted_array = array.uniq.sort
    @root = build_tree(sorted_array, 0, sorted_array.length - 1)
  end

  def build_tree(sorted_array, start, finish)
    return nil if start > finish
    return Node.new(sorted_array[start]) if start == finish

    mid = start + (finish - start) / 2
    root = Node.new(sorted_array[mid])
    root.left = build_tree(sorted_array, start, mid - 1)
    root.right = build_tree(sorted_array, mid + 1, finish)
    root
  end

  def insert(value, node)
    if node.nil?
      return Node.new value
    end

    if value < node.value
      node.left = insert value, node.left
    elsif value > node.value
      node.right = insert value, node.right
    else
      return node
    end

    balance_factor = balance_factor(node)

    if balance_factor > 1 && value < node.left.value
      # left-left 
      node = right_rotate(node)
    elsif balance_factor > 1 && value > node.left.value
      # left-right
      node.left = left_rotate(node.left)
      node = right_rotate(node)
    elsif balance_factor < -1 && value > node.right.value
      # right-right
      node = left_rotate(node)
    elsif balance_factor < -1 && value < node.right.value
      # right-left
      node.right = right_rotate(node.right)
      node = left_rotate(node)
    end
    node
  end

  def delete(value, node)
    if node.nil?
      return node
    end

    if value < node.value
      node.left = delete(value, node.left)
    elsif value > node.value
      node.right = delete(value, node.right)
    else
      if node.left.nil? || node.right.nil?
        temp = nil
        if temp == node.left
          temp = node.right
        elsif temp == node.right
          temp = node.left
        end

        if temp.nil?
          temp = node
          node = nil
        else
          node = temp
        end
      else
        temp = node.right
        if !temp.left.nil?
          temp = temp.left
        end
        node.value = temp.value
        node.right = delete(temp.value, node.right)
      end
    end

    unless node.nil?
      balance_factor = balance_factor(node)

      # left-left-case
      if balance_factor > 1 && balance_factor(node.left) >= 0
        node = right_rotate(node)
      # left-right case
      elsif balance_factor > 1 && balance_factor(node.left) < 0
        node.left = left_rotate(node.left)
        node = right_rotate(node)
      # right-right case
      elsif balance_factor < 1 && balance_factor(node.right) <= 0
        node = left_rotate(node)
      # right-left case
      elsif balance_factor < 1 && balance_factor(node.right) > 0
        node.right = right_rotate(node.right)
        node = left_rotate(node)
      end
    end

    node
  end
  def find_height(node)
    if node.nil?
      return 0
    end

    [find_height(node.left), find_height(node.right)].max + 1
  end

  def right_rotate(node)
    left_child = node.left
    left_child_right_child = left_child.right

    left_child.right = node
    node.left = left_child_right_child

    left_child
  end

  def left_rotate(node)
    right_child = node.right
    left_child_right_child = right_child.left

    right_child.left = node
    node.right = left_child_right_child

    right_child
  end

  def balance_factor(node)
    if node.nil?
      return 0
    end
    find_height(node.left) - find_height(node.right)
  end

  def find(value)
    find_node(value, @root)
  end

  def find_node(value, root)
    result_node = nil
    if root.nil?
      return result_node
    end

    if value == root.value
      result_node = root
    elsif value < root.value
      result_node = find_node(value, root.left)
    else
      result_node = find_node(value, root.right)
    end

    result_node
  end

  def level_order
    node = @root
    queue = Array.new(1, node)

    until queue.empty? || node.nil?
      node = queue.pop
      unless node.left.nil?
        queue.prepend(node.left)
      end

      unless node.right.nil?
        queue.prepend(node.right)
      end

      print "#{node.value} "
    end

  end

  def preorder(root, block)
    if root.nil?
      return
    end

    unless block.nil?
      block.call(root)
      preorder(root.left, block)
      preorder(root.right, block)
    end
    
  end

  def inorder(root, block)
    if root.nil?
      return
    end

    unless block.nil?
      inorder(root.left, block)
      block.call(root)
      inorder(root.right, block)
    end
    
  end

  def postorder(root, block)
    if root.nil?
      return
    end

    unless block.nil?
      postorder(root.left, block)
      postorder(root.right, block)
      block.call(root)
    end
    
  end

  def find_depth(value)
    root_height = find_height(@root)
    node = find_node(value, @root)
    node_height = find_height(node)
    root_height - node_height
  end

  def balanced? 
    if balance_factor(@root) < 2
      return true
    end
    false
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

tree = Tree.new(gets.chomp.split(',').map(&:to_i))
tree.pretty_print
puts tree.balance_factor(tree.root)
tree.insert(10, tree.root)
tree.pretty_print
tree.root = tree.insert(20, tree.root)
tree.pretty_print
tree.root = tree.insert(30, tree.root)
tree.pretty_print
tree.root = tree.insert(40, tree.root)
tree.pretty_print
tree.root = tree.insert(50, tree.root)
tree.pretty_print
tree.root = tree.insert(60, tree.root)
tree.pretty_print
puts tree.balance_factor(tree.root)
tree.pretty_print
tree.root = tree.delete(20, tree.root)
tree.pretty_print
tree.root = tree.delete(2, tree.root)
tree.pretty_print
tree.root = tree.delete(10, tree.root)
tree.pretty_print
p tree.find(4)
tree.level_order
puts
block = ->(node) { print "#{node.value} " }
tree.preorder(tree.root, block)
puts
tree.inorder(tree.root, block)
puts
tree.postorder(tree.root, block)
puts
puts "Depth of node 1 ::: #{tree.find_depth(1)}"
puts "Is Tree Balanced? ::: #{tree.balanced?}"
