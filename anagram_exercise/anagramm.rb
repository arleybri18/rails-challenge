require 'minitest/spec'
require 'minitest/autorun'

# anagram? - detects if 2 words are an anagram of one another
# @param word1 [string]
# @param word2 [string]
# @return true if they are anagrams, false if not

# TODO: declare and implement the function here.
def anagram?(word1, word2)
  first_string = word1.downcase.chars.sort.join
  second_string = word2.downcase.chars.sort.join
  first_string == second_string
end

describe 'anagram?' do
  it 'same characters but position shifted are anagrams' do
    assert_equal true, anagram?('abcd', 'cbda')
  end

  it 'word with same characters and repeated characters but position shifted are anagrams' do
    assert_equal true, anagram?('abbcdbbbb', 'bbbbcbbda')
  end

  it 'different characters are not anagrams' do
    assert_equal false, anagram?('hello', 'zdfat')
  end
end
