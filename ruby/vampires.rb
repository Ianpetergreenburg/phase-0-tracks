puts "What is your name?"
name = gets.chomp
puts "How old are you?"
age = gets.chomp.to_i
puts "What year were you born?"
birth_year = gets.chomp.to_i
real_age = 2016 - birth_year
puts "Would you like some garlic bread?"
garlic_bread = gets.chomp
puts "Would you like to enroll in the company health insurance?"
health_ins = gets.chomp
puts name
puts age
puts birth_year
puts real_age
puts garlic_bread
puts health_ins
if 