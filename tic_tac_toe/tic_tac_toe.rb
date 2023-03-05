# tic-tac-toe
# program takes 9 inputs at max
# every input should be alternatively assigned to two players 
# after every input, check if anyone won the game
# If a player wins, END the game
# If inputs max-out, no player wins, DRAW and END the game
# user boolean values => true or false to represent each player

# To determine if a player won the game,
# The 2-D array should have same values in a row or column or diagonal
# check every row, check every column and check the diagonal
# Let's say player1 -> 0, player2 -> 1
def check_for_win board 
  board.each_with_index do |row, index|
    # check the rows
    return row[0] if contains_same_elements?(row)
  end

  board.each_with_index do |row, column_index|
    # check the columns
    return board[0][column_index] if contains_same_elements_column?(board, column_index)
  end

  # check the diagonal
  return board[0][0] if contains_same_elements_diaganol? board
  
  return -1
end

def contains_same_elements? array
  return false if array[0] == -1
  result = true
  array[1..-1].each_with_index do |value, index|
    result = false if value != array[index - 1] || value == -1
  end
  result
end

def contains_same_elements_column? board, column_index
  return false if board[0][column_index] == -1
  for i in 1..2
    return false if board[i][column_index] != board[i - 1][column_index] || board[i][column_index] == -1
  end
  true
end

def contains_same_elements_diaganol? board
  reutrn false if board[0][0] == -1
  for i in 1..2
    return false if board[i][i] == board[i - 1][i - 1] || board[i][i] == -1
  end
  true
end

def display_board board
  board.each_with_index do |row, index|
    p row
  end
end

def play 
  board = Array.new(3) { Array.new(3, -1) }
  count = 0
  player = 1
  who_won = -1
  while count <= 9
    count += 1
    player == 1 ? puts("Player 1\'s Turn") : puts("Player 2\'s Turn")
    puts "Please enter you choice of position"
    pos = gets.chomp.split(",");
    board[pos[0].to_i - 1][pos[1].to_i - 1] = player
    display_board board
    player = player == 1 ? 2 : 1
    next if count < 5
    who_won = check_for_win board
    if who_won == 1
      puts "Player 1 wins!!!!!"
      break
    else who_won == 2
      puts "Player 2 wins!!!!!"
      break
    end
  end

  if who_won == -1
    puts "Game DRAW!!!"
  end
end

play
