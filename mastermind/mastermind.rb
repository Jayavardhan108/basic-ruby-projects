
# when the game starts, choose whether the player wants to be code_maker or code_breaker
# if code_breaker, computer randomly chooses a code 4 colors out of COLORS array
# code_breaker will have 12 chances to guess the code
# Everytime, code_breaker should input 4 values seperated by ','
# that input will be checked with the code
# How input will be checked against code?
# 1. check if any of the colors are guessed correctly at the position
# then print color matched at <position> position
# 2. else if check if atleast guessed colors are available in the code,
# then print <color> is available in the code but in wrong position
# 3. else if guessed color is not present in code,
# print <color> is not present in code

module Mastermind
  COLORS = ['violet', 'indigo', 'yellow', 'blue', 'green', 'orange', 'red']
  
  def play
    puts 'Lets the Game Begins!!!!!'
    puts 'Do you want to be code_maker(1) or code_breaker(2)?. Please select the number'
    choice = gets.chomp.to_i;
    if choice == 1
      play_code_maker
    elsif choice == 2
      play_code_breaker
    else
      puts 'Invalid choice!!!!'
    end
  end

  def play_code_breaker
    code = []
    4.times { code.push COLORS[rand COLORS.length] }
    # p code
    is_game_won = false
    puts 'Alright CODE MAKER!, lets start guessing'
    12.times do |chance_count|
      puts "\n COLORS = #{COLORS}"
      puts "\nPlease provide your choice of code"
      guess = gets.chomp.split(",")
      code_hash = code.reduce(Hash.new(0)) do |hash, color|
        hash[color] += 1
        hash
      end
      guess.each_with_index do |guessed_color, index|
        if 'guessed correctly' == code[index]
          next  
        end
        if guessed_color == code[index]
          puts "Hurray!!!, your guessed color #{guessed_color} is at #{index} in code"
          code[index] = 'guessed correctly'
        elsif code_hash.include? guessed_color and code_hash[guessed_color] > 0
          puts "You are close buddy!, your guessed color #{guessed_color} is in code but at a differnet index"
          code_hash[guessed_color] -= 1
        elsif COLORS.include? guessed_color
          puts ":( Sorry Pal!, your guessed color #{guessed_color} is not in the code"
        else
          puts "your guessed color #{guessed_color} is not even the COLORS list"
        end
      end

      is_game_won = code.reduce(true) { |result, color| result && color == 'guessed correctly'}
      if is_game_won
        puts "Yayyyyy!!!!!!, You won the game, Congrats!!!!!"
        break
      end
      puts "Chances left: #{11 - chance_count}"
    end
    if !is_game_won
      puts "Sorry mate!!!, You lost the game"
    end
  end
end  
