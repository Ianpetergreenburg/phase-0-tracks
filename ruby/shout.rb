module Shout
  # def self.yell_angrily(words)
  #   words + "!!!" + " :("
  # end

  # def self.yell_happily(words)
  #   words + "!!1!" + " xDD"
  # end

  def yell_angrily(words)
    puts words + "!!!" + " :("
  end

  def yell_happily(words)
    puts words + "!!1!" + " xDD"
  end
end

class DragonBorn
  include Shout
end

class  American
  include Shout
end

american =  American.new
american.yell_happily("McDonalds")
american.yell_angrily("The French")
dovahkin = DragonBorn.new
dovahkin.yell_angrily("Fus Ro Dah")
dovahkin.yell_happily("Skyrim is for the Nords")
# p Shout.yell_happily("Dude")
# p Shout.yell_angrily("Dude")