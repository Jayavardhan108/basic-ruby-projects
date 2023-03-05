MIN_ASCII_VALUE_UP = 'A'.ord
MIN_ASCII_VALUE_DOWN = 'a'.ord
MAX_ASCII_VALUE_UP = 'Z'.ord
MAX_ASCII_VALUE_DOWN = 'z'.ord
def ceaser_cipher(text, shift)
  # split the string to char array
  # add <shift> to ascii code of individual chars, convert them back to chars
  # Handling cycle:
  # 1. forward-cycle:
  # if final ascii value is > maximum ascii value('z' or 'Z')
  # then find the remainder = ascii_value % max_ascii_value
  # and add remainder to minimum ascii value('a' or 'A')
  # 2. backward-cycle:
  # if final ascii value < minimum ascii value('a' or 'A')
  # the find the remainder = mim_ascii_value % ascii_value
  # then subtract remainder from maximum ascii value('z' or 'Z')

  charArr = text.split ''
  charArr.reduce('') do |result, char|
    if char >= 'a' && char <= 'z'
      result.concat convert char, shift, MIN_ASCII_VALUE_DOWN, MAX_ASCII_VALUE_DOWN
    elsif char >= 'A' && char <= 'Z'
      result.concat convert char, shift, MIN_ASCII_VALUE_UP, MAX_ASCII_VALUE_UP
    else
      result.concat char
      result
    end
  end
end

def convert(char, shift, min_value, max_value)
  shifted_ascii_value = char.ord + shift
  if shifted_ascii_value > max_value
    remainder = (shifted_ascii_value - max_value) % 26
    return max_value.chr if remainder == 0

    shifted_ascii_value = remainder - 1 + min_value

  end

  if shifted_ascii_value < min_value
    remainder = (min_value - shifted_ascii_value) % 26
    return min_value.chr if remainder == 0

    shifted_ascii_value = max_value - remainder + 1

  end
  shifted_ascii_value.chr
end

puts ceaser_cipher 'This is representation of CEASER-CIPHER', 150
puts ceaser_cipher 'Nbcm cm lyjlymyhnuncih iz WYUMYL-WCJBYL', -150

puts ceaser_cipher 'Ruby is fun!', 52
puts ceaser_cipher 'Ruby is fun!', -52
