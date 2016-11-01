#In phase-0-tracks/ruby/hashes.rb, pseudocode and
# write a program that will allow an interior designer
# to enter the details of a given client: the
# client's name, age, number of children,
# decor theme, and so on (you can choose your own
# as long as it's a good mix of string, integer,
# and boolean data

#create a blank hash
#have client answer questions with correct data type


client_info = {
	name: "",
	age: nil,
	has_pets: false,
	number_children: nil,
	decor_theme: "",
	dislikes: "",
	goal_budget: nil,
	wants_contractor: false,
	fav_color: "",
}

puts "Hello. Welcome to Star Interior Decorators, where you, the client
	is the real star."
puts "Please fill out the following questions to help us get to know you."
puts "First off, what would you like us to call you?"
client_info[:name] = gets.chomp
puts "Great to meet you " + client_info[:name]
puts "Could I also get your age?"
client_info[:age] = gets.chomp.to_i
until client_info[:age] != nil && client_info[:age] != 0
	 	puts "Please write your age in numbers"
 		client_info[:age] = gets.chomp.to_i
 end
 puts "You look so young for someone who's " + client_info[:age].to_s

  puts "Do you have any pets? Please answer yes or no"
 answer = nil
 until answer == "yes" || answer == "no"
 	answer = gets.chomp
 	if answer == "yes" || answer == "no"
 		if answer == "yes"
 			client_info[:has_pets] = true
 		end
 	else 
 		puts "please answer yes or no"
 	end
 end

puts "How many children do you have?"
a4 = gets.chomp
temp4 = a4.to_i
until temp4 > 0 || a4 == "0"
 	 puts "Please write your answer with numbers"
  	 a4 = gets.chomp
  	 temp = a4.to_i
end
client_info[:number_children] = temp4

puts "What would you like to be the main theme of the design?"
client_info[:decor_theme] = gets.chomp
puts client_info[:decor_theme] + "? That sounds positively lovely!"

puts "Please list anything you don't want included in your design. (leave blank if there is nothing you don't want to include)"
a6 = gets.chomp
client_info[:dislikes] = a6
until a6.to_s.empty?
	puts "is there anything else you don't want included? (leave blank if there is nothing else)"
	a6 = gets.chomp
	if not a6.empty?
		client_info[:dislikes] = client_info[:dislikes] + ", " + a6
	end
end

puts "What is your planned budget for this job?"
a7 = gets.chomp.delete '$'
temp7 = a7.to_i
until temp7 > 0 && a7 != "0"
	if a7 == "0"
		puts "Unfortunately we can't work with no budget. Please give us an amount greater than 0."
	elsif temp7 < 0
		puts "Negative budget? Try again."
	else
 		 puts "Please write your answer with numbers"
 	end
  	 a7 = gets.chomp.delete '$'
  	 temp7 = a7.to_i
end
client_info[:goal_budget] = temp7