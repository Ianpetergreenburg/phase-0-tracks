#hellos and prompt for name
puts "Hello and welcome to Hamsterville USA"
puts "What is this hamster's name"
name = gets.chomp

vol = 0
#Prompt for vol lvl

while vol <= 0 || vol > 10
 puts "On like around a scale from 1-10, how squeeky is it"
 vol = gets.chomp
 vol = vol.to_i

end
#prompt for furrrrrrr
puts "What color is this hamsters furrrrrrr"
fur = gets.chomp

loveable = 0
#if they can be loveable
if loveable != "yes" || loveable != "no"
	puts "Is this hamster cute and cuddly, yes or no answers only please"
	puts "Yes I know that is a hard question....deal"
	loveable = gets.chomp

end
#Age
age = nil
puts "And their age is?  Feel free to leave blank"
age = gets.chomp
age.to_i
puts "The little furry jerks name is"
puts name
puts "His/Her/Zer's volume level is"
puts vol
puts "And with fur the color of"
puts fur
puts "You answered is this being lovable with a "
puts loveable
puts "And an age of"
puts age