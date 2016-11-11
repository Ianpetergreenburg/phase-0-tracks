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
   let(:wordgame) { WordGame.new("test") }

   it "takes a guess and returns boolean of if it is in the word" do
      expect(wordgame.guess("t")).to eq true
      expect(wordgame.guess("q")).to eq false
  end

  it "keeps track if the game is won" do
      expect(wordgame.gamewon?).to eq false
  end

  it "creates a gameboard equal to length of gameword" do 
      expect(wordgame.gameboard).to eq ["_","_","_","_"]
  end

it "checks if whatever is passed is a string of only letters" do
  expect(isword?("cc")).to eq true
  expect(isword?("Test")).to eq true
  expect(isword?("Test4")).to eq false
  expect(isword?("c c")).to eq false
  expect(isword?("")).to eq false
end

  it "checks if whatever is passed is a single letter" do
   expect(isletter?("c")).to eq true
   expect(isletter?("bc")).to eq false
   expect(isletter?(" ")).to eq false
   expect(isletter?("4")).to eq false
   expect(isletter?("C")).to eq true
end

end

