Alphabet = "abcdefghijklmnopqrstuvwxyz"

class WordGame
  attr_reader :guesses, :gameboard, :gameover
  attr_reader :word

  def initialize(word)
  @word = word.downcase
  @guesses = word.length + 2
  @gameboard = Array.new(word.length){|x| "_"}
  @guessed_letters = []
  @gameover = false
  end

  def guess(letter)
    correct = false
  if @guessed_letters.include? letter
      puts "please guess a letter you have not tried yet"
  else
      @guessed_letters << letter
        if @word.include? letter
            @word.length.times do |i| 
                if @word[i] == letter
                    @gameboard[i] = letter
                    correct = true
                end
            end
        end
        @guesses -= 1
    end
    return correct
  end

  def gameover?
     @gameover = (@gameboard.join == @word)
  end

end

def isletter?(letter)
  if not letter.empty?
    return (Alphabet.include? letter) && (letter.length == 1)
  else
    return false
  end
end

def isword?(word)
  # if word == "" || word == nil
  #   return false
  # end
  word = word.downcase
  word.length.times do |i|
    if not isletter?(word[i])
      return false
    end
  end
  return true
end

#end
#begins with asking the first user a word to play with
puts "player1, please enter the word you would like your partner to guess"
#that word is then accepted and a blank form of the word is created
gameword = gets.chomp.downcase

until isword?(gameword)
  puts "please only use letters in your word"
  gameword = gets.chomp.downcase
end

game = WordGame.new(gameword)
#generate an appropriate amount of guesses dependent on the amount of letters in the word
until game.guesses == 0 || game.gameover?
#accept a guess letter
    puts "player2, you have " + game.guesses.to_s + " guesses left."
    current_guess = gets.chomp.downcase

    until isletter?(current_guess)
      puts "please only guess with a single letter"
      current_guess = gets.chomp.downcase
    end

    game.guess(current_guess)

    puts "your gameboard currently looks like"
    puts game.gameboard.join(' ').dump

    if game.gameover?
      puts "Congratulations on guessing the correct word, " + game.word
      break
    end

end

if not game.gameover?
  puts "Turns out the word was " + game.word + ", you silly goose. Womp womp."
end
#make sure it hasn't been guessed before
#if it hasn't check if it is in the word
#if it is then reveal the letter in the blank form
#--add the letter to a cache of guessed letters
#--decrease the guess count
#if game is won give a congratulatory message
#if guess count hits 0 then give losing message