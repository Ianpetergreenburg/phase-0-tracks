class WordGame
  Alphabet = "abcdefghijklmnopqrstuvwxyz"
  attr_reader :guesses, :gameboard, :gamewon
  attr_accessor :word

  def initialize(word)
    #cast word to 
  @word = word.downcase
  @wordarr = word.downcase.split('')
  @guesses = word.length + 5
  @gameboard = Array.new(word.length){"_"}
  @guessed_letters = []
  @gamewon = false
  end

  #Take in a letter  and return how many times it is in the game word
  #also update game board to reveal where guessed letter exists in the word
  def guess(letter)
        letter = letter.downcase
        num = 0
        #iterate through word comparing guessed letter to letter's in the word
        @wordarr.each_index do |i| 
               if @wordarr[i] == letter
                      #if the letter matches update the game board in the equivalent spot
                       @gameboard[i] = letter
                       num += 1
                end
        end
        #add letter to guessed database, and lower amount of guesses by one
        @guessed_letters << letter
        @guesses -= 1
        return num
  end

#Determine if game is won by all letters being guess or whole word guessed
  def gamewon? (guess = "")
        @gamewon = (@gameboard == @wordarr || @word == guess)
  end

#determine if input is a letter by it's length and if it's in the Alphabet string
 def isletter?(letter)
        (Alphabet.include? letter.downcase) && (letter.length == 1)
 end

#determine if word by iterating through string and seeing if each character is a letter
#return true if the word is made of only letters and isn't an empty string
 def isword?(word)
        word = word.downcase
        word.each_char { |c| return false if not isletter?(c) }
        !word.empty?
 end

#determine whether or not a given letter has already been gueseed by checking guess database
 def alreadyguessed? (letter)
        letter = letter.downcase
        @guessed_letters.include? letter
 end
end

#Ask Users for their name and get Player2 to leave and ask Player1 to give a word to use
puts "Welcome players to the Fantastic Word Game!"
puts "Player1 please enter your name"
player1 = gets.chomp
puts "Player2 please enter your name"
player2 = gets.chomp
puts "\n#{player2}, please step away from the game while #{player1} chooses a word"
puts "#{player1}, please enter the word you would like your partner to guess"

#take in a word and use it to start the game
gameword = gets.chomp
game = WordGame.new(gameword)
#loop until users input is a string of only letters/not empty 
until game.isword?(game.word)
  puts "please only use letters in your word"
  gameword = gets.chomp
  game  = WordGame.new(gameword)
end

#Bring Player2 back and clear the board so they can't see Player1's input
puts "That's a great word! Once you press enter bring #{player2} back to play!"
gets
50.times {puts ""}

#Start Player2's game and prompt for an initial guess
puts "#{player2}, now is your time to guess #{player1}'s mystery word."
puts "You have #{game.guesses} chances to guess the letters in it."
puts "The gameboard currently looks like:"
puts game.gameboard.join(' ').dump
puts "Please enter a single letter to make a guess."

#while there are still guesses available accept guesses from user
while game.guesses > 0

#gather a guess from the user
#make them guess again if they didn't guess a letter or the letter as been guessed already
  current_guess = gets.chomp
  while !game.isletter?(current_guess) || game.alreadyguessed?(current_guess)
        puts "Please guess only with a single letter" if !game.isletter?(current_guess)
        puts "Please guess a letter you have not tried yet." if game.alreadyguessed?(current_guess)
        current_guess = gets.chomp
 end

#guess the letter and get the amount of times the letter was present
 revealed = game.guess(current_guess) 
 #set the guess to correct if any letters were revealed
correct = revealed > 0
#congratulate or notify user how many letters they uncovered
 puts "You revealed #{revealed} letters!" if revealed != 1
 puts "You revealed #{revealed} letter!" if revealed == 1
 puts "Awesome!" if revealed > 0
#show user the current state of the game board
 puts "\nYour gameboard now currently looks like:" if correct
 puts "\nYour gameboard is still:" if !correct
 puts game.gameboard.join(' ').dump

#check if the last guess won the game and congratulate the user if so and end the game
 if game.gamewon?
        puts "Congratulations on guessing the correct word, #{game.word}"
        break
 end

#notify users how many guesses they have left
 puts "You still have #{game.guesses} guesses left." if game.guesses > 1
 puts "Make another guess!" if game.guesses > 0
 #if last guess give possibility to guess the whole word or just another letter
 if game.guesses == 1
        puts "Would you like to use your last guess to guess the whole word? (yes/no)"
        answer = gets.chomp
        #make sure the user gives a clear yes or no to guessing the whole word
        until answer == 'yes' or answer == 'no'
               puts "Please answer yes or no"
                answer = gets.chomp
        end
        #if they want to guess the whole word, check their guess against the game word
        if answer == 'yes'
               puts "Please enter what you think the final word might be"
               guess = gets.chomp.downcase
               #congratulate the user if they were right
               if game.gamewon? (guess)
                       puts "Congratulations on guessing the correct word, #{game.word}"
               end
               #end the guesses
               break
        end
        #prompt for a letter if they don't want to guess the whole word
        puts "Alright guess a letter then!"
 end
end

#if the user didn't win taunt them
if not game.gamewon
  puts "Turns out the word was #{game.word}, you silly goose. Womp womp."
end