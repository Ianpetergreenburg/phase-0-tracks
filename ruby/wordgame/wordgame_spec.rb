#begins with asking the first user a word to play with
#that word is then accepted and a blank form of the word is created
#generate an appropriate amount of guesses dependent on the amount of letters in the word
#accept a guess letter
#make sure it hasn't been guessed before
#if it hasn't check if it is in the word
#if it is then reveal the letter in the blank form
#--add the letter to a cache of guessed letters
#--increase the guess count
#if game is won give a congratulatory message
#if guess count hits 0 then give losing message

require_relative 'wordgame'

describe WordGame do
   let(:wordgame) { WordGame.new("testtest") }

   it "takes a guess and returns boolean of if it is in the word" do
    isletter = "t"
    isnotletter = "q"
      expect(wordgame.guess(isletter)).to eq true
      expect(wordgame.guess(isnotletter)).to eq false
  end

  it "keeps track if the game is over" do
      expect(wordgame.gameover?).to eq false
      wordgame.
  end

  it "creates a gameboard equal to length of gameword"
end

