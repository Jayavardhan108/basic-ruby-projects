$dict = %w[below down go going horn how howdy it i low own part partner sit]
def find_substrings_of_word(word, dictionary = $dict, hash = Hash.new(0))
  dictionary.each do |substring|
    substring_occurrences = word.scan(substring).length
    hash[substring] += substring_occurrences if substring_occurrences > 0
  end
  hash
end

def find_substrings_of_sentence(sentence, dictionary = $dict)
  sentence.strip.split(' ').reduce(Hash.new(0)) { |hash, word| find_substrings_of_word word, dictionary, hash }
end

puts find_substrings_of_word 'below'

puts find_substrings_of_sentence 'below down going', $dict
