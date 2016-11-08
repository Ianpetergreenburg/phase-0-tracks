class Santa

  def speak
     puts "Ho, ho, ho! Haaaappy holidays!"
  end

  def eat_milk_and_cookies(cookie)
     puts "That was a good " + cookie
  end

  def initialize(gender, ethnicity)
     puts "Initializing Santa instance..."
     @gender = gender
     @ethnicity = ethnicity
     @reindeer_ranking = ["Rudolph", "Dasher", "Dancer", "Prancer", "Vixen", "Comet", "Cupid", "Donner", "Blitzen"]
     @age = 0
  end
end

# chris = Santa.new
# chris.speak
# chris.eat_milk_and_cookies("sugar cookie")
# puts Santa.coat_trim + " was there"

santas = []
example_genders = ["agender", "female", "bigender", "male", "female", "gender fluid", "N/A"]
example_ethnicities = ["black", "Latino", "white", "Japanese-African", "prefer not to say", "Mystical Creature (unicorn)", "N/A"]
example_ethnicities.each_index {|x| santas << Santa.new(example_genders[x], example_ethnicities[x])}
p santas