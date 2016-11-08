class Santa
attr_reader  :ethnicity
attr_accessor :gender, :age
  def speak
     puts "Ho, ho, ho! Haaaappy holidays!"
  end

  def eat_milk_and_cookies(cookie)
     puts "That was a good " + cookie
  end

  def initialize(gender, ethnicity)
     #puts "Initializing Santa instance..."
     @gender = gender
     @ethnicity = ethnicity
     @reindeer_ranking = ["Rudolph", "Dasher", "Dancer", "Prancer", "Vixen", "Comet", "Cupid", "Donner", "Blitzen"]
     @age = 0
  end

  def celebrate_birthday
    @age += 1
end

def get_mad_at (reindeer)
  @reindeer_ranking.delete(reindeer)
  @reindeer_ranking << reindeer
end

end

# chris = Santa.new
# chris.speak
# chris.eat_milk_and_cookies("sugar cookie")
# puts Santa.coat_trim + " was there"

santas = []
santa_amount = 200

example_genders = ["agender", "female", "bigender", "male", "female", "gender fluid", "N/A"]
example_ethnicities = ["black", "Latino", "white", "Japanese-African", "prefer not to say", "Mystical Creature (unicorn)", "N/A"]
example_ethnicities.each_index {|x| santas << Santa.new(example_genders[x], example_ethnicities[x])}
santas[0].gender = "white"
santas[0].celebrate_birthday
p santas[0].age
p santas[0]

santa_amount.times do |x|
  new_santa = Santa.new(example_genders.sample, example_ethnicities.sample)
  new_santa.age = rand(140)
  puts "This Santa is " + new_santa.ethnicity + " and " + new_santa.gender+ " and " + new_santa.age.to_s + " year(s) old."
end