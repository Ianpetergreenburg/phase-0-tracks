require_relative 'wordgame'

describe WordGame do
   let(:wordgame) { WordGame.new("test") }

  it "has a gameboard that keeps track of guesses" do 
      expect(wordgame.gameboard).to eq ["_","_","_","_"]
      wordgame.guess("t")
      expect(wordgame.gameboard).to eq ["t","_","_", "t"]
  end

   it "takes a guess and returns boolean of if it is in the word" do
      expect(wordgame.guess("t")).to eq 2
      expect(wordgame.guess("q")).to eq 0
  end

  it "keeps track if the game is won" do
      expect(wordgame.game_won?).to eq false
      wordgame.guess("t")
      wordgame.guess("e")
      wordgame.guess("s")
      expect(wordgame.game_won?).to eq true
  end

it "checks if whatever is passed is a string of only letters" do
  expect(wordgame.is_word?("cc")).to eq true
  expect(wordgame.is_word?("Test")).to eq true
  expect(wordgame.is_word?("Test4")).to eq false
  expect(wordgame.is_word?("c c")).to eq false
  expect(wordgame.is_word?("")).to eq false
end

  it "checks if whatever is passed is a single letter" do
   expect(wordgame.is_letter?("c")).to eq true
   expect(wordgame.is_letter?("bc")).to eq false
   expect(wordgame.is_letter?(" ")).to eq false
   expect(wordgame.is_letter?("4")).to eq false
   expect(wordgame.is_letter?("C")).to eq true
   expect(wordgame.is_letter?("")).to eq false
end

it "checks if a letter has already been guessed" do
  expect(wordgame.already_guessed?("t")).to eq false
  wordgame.guess("t")
  expect(wordgame.already_guessed?("t")).to eq true
end
end

