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
    find_height(node.left) - find_height(node.right)
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

