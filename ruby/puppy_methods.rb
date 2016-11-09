class Puppy

  def initialize
      puts "Initializing new puppy instance ..."
  end

  def fetch(toy)
    puts "I brought back the #{toy}!"
    toy
  end

  def speak(num)
    num.times{|x| puts "Woof!"}
  end

  def  rollover()
    puts "*rollover*"
  end

  def dog_years (human_years)
    human_years * 7
  end

  def jump(str)
      if str == "treat"
        puts "jump up and down"
      end
  end
end

spot = Puppy.new
spot.fetch("ball")
spot.speak(3)
spot.rollover
p spot.dog_years(5)
spot.jump("treat")

class Kitty

  def initialize
     puts "Initializing Kitty..."
  end

  def sip_milk
    puts "*slurp slurp*"
  end

  def potty
    puts "*goes to litterbox*"
  end
end

kitty_arr = []
num = 50
until num == 0
 kitty_arr << Kitty.new
  num -=1
end
#p kitty_arr
kitty_arr.each do |x|
  x.sip_milk
  x.potty
end


