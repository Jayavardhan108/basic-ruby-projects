require_relative 'recursion'

class Main
  extend Recursion
end

array = gets.chomp.split(',').map(&:to_i)
p Main.merge_sort array
