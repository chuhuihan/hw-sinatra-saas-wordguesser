class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    if letter != nil && letter.match(/^[a-zA-z]$/) 
      lower = letter.downcase
      if !@guesses.include?(lower) && !@wrong_guesses.include?(lower)
        if @word.include?(lower) 
          @guesses += lower
        else
          @wrong_guesses += letter
        end
        true
      else
        false
      end
    else
      raise ArgumentError
    end
  end

  def word_with_guesses()
    result = ''
    @word.each_char do |i|
      if @guesses.include?(i)
        result += i
      else
        result += '-'
      end
    end
    return result
  end

  def check_win_or_lose()
    if @wrong_guesses.length == 7
      return :lose
    elsif word_with_guesses().include?('-')
      return :play
    else
      return :win
    end
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start do |http|
      return http.post(uri, "").body
    end
  end
end
