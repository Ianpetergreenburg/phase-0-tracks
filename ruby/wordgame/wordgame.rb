Alphabet = "abcdefghijklmnopqrstuvwxyz"

class WordGame
  attr_reader :guesses, :gameboard, :gameover
  attr_reader :word

  def initialize(word)
  @word = word
  @wordarr = word.downcase.split('')
  @guesses = word.length + 2
  @gameboard = Array.new(word.length){|x| "_"}
  @guessed_letters = []
  @gamewon = false
  end

  def guess(letter)
  correct = false
  if @guessed_letters.include? letter
      puts "please guess a letter you have not tried yet" 
  else
        @wordarr.each_index do |i| 
               if @wordarr[i] == letter
                       @gameboard[i] = letter
                       correct = true
                end
            end
        @guessed_letters << letter
        @guesses -= 1
    end
  return correct
  end

  def gamewon?
     @gamewon = (@gameboard.join == @word)
  end

end

def isletter?(letter)
    return (Alphabet.include? letter.downcase) && (letter.length == 1)
end

def isword?(word)
  word = word.downcase
  word.each_char { |c| return false if not isletter?(c) }
  return !word.empty?
end

#end
#begins with asking the first user a word to play with
puts "player1, please enter the word you would like your partner to guess"
#that word is then accepted and a blank form of the word is created
gameword = gets.chomp

until isword?(gameword)
  puts "please only use letters in your word"
  gameword = gets.chomp
end

game = WordGame.new(gameword)

while game.guesses > 0
  puts "Player2, you still have " + game.guesses.to_s + " guesses left."
  current_guess = gets
  break if current_guess == nil
  current_guess = current_guess.chomp

  while !isletter?(current_guess)
        puts "please only guess with a single letter"
        current_guess = gets
        break if current_guess == nil
        current_guess = current_guess.chomp
 end

 game.guess(current_guess)

 puts "your gameboard now currently looks like"
 puts game.gameboard.join(' ').dump

  if game.gamewon?
        puts "Congratulations on guessing the correct word, " + game.word
        break
  end
end

if not game.gamewon?
  puts "Turns out the word was " + game.word + ", you silly goose. Womp womp."
end

#generate an appropriate amount of guesses dependent on the amount of letters in the word
#make sure it hasn't been guessed before
#if it hasn't check if it is in the word
#if it is then reveal the letter in the blank form
#--add the letter to a cache of guessed letters
#--decrease the guess count
#if game is won give a congratulatory message
#if guess count hits 0 then give losing message