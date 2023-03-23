require_relative 'node'

class Tree
  attr_accessor :array
  attr_reader :root

  def initialize(array)
    @array = array
    sorted_array = array.uniq.sort
    @root = build_tree(sorted_array, 0, sorted_array.length)
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

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

tree = Tree.new(gets.chomp.split(',').map(&:to_i))
tree.pretty_print
