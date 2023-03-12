puts 'Hangman Starts!!!'

all_words = File.open 'google-10000-english-no-swears.txt'

selected_words = all_words.readlines.reduce([]) do |words, word|
  word.chomp!
  words.push(word) if word.length >= 5 && word.length <= 12
  words
end

puts "Selecting a random word out of #{selected_words.length}"
random_word = selected_words[rand(selected_words.length)]
puts random_word
random_word_chars = random_word.split('')

len_of_word = random_word_chars.length
guessing_array = Array.new(len_of_word, '_')

guesses_left = len_of_word
puts 'START GUESSING!!!'

p guessing_array

loop do
  puts "\nYou have #{guesses_left} guesses left"

  unless guessing_array.include? '_'
    puts "\nHurray!!!!, You WIN!!\n #{guessing_array}"
    break
  end

  if guesses_left.zero?
    puts "\nYou Lose!!, There are no chances left"
    break
  end
  guesses_left -= 1

  guess = gets.chomp
  if guess.length > 1
    if guess == random_word
      guessing_array = random_word_chars
      puts "\nHurray!!!!, You WIN!!\n\n #{guessing_array}"
      break
    else
      puts "\nYour guessed word is not correct :(\n\n#{guessing_array}"
      next
    end
  end

  unless random_word_chars.include? guess
    puts "\nYour guess #{guess} is not in the word"
    next
  end

  random_word_chars.each_with_index do |char, index|
    if char == guess
      guessing_array[index] = guess
      puts "\nNice!!, Your guess is in the word!\n\n#{guessing_array}"
    end
  end
end
