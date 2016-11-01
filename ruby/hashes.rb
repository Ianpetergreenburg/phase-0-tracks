client_info = {
	name:"",
	age:nil,
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
puts ""
puts "First off, what would you like us to call you?"
client_info[:name] = gets.chomp
puts "Great to meet you " + client_info[:name] + "!"
puts ""
puts "Could I also get your age?"
client_info[:age] = gets.chomp.to_i
until client_info[:age] != nil && client_info[:age] != 0
	 	puts "Please write your age in numbers"
 		client_info[:age] = gets.chomp.to_i
 end
 puts "You look so young for someone who's " + client_info[:age].to_s + "!"
 puts ""
 puts "Do you have any pets? Please answer yes or no"
 answer = nil
 until answer == "yes" || answer == "no"
 	answer = gets.chomp
 	if answer == "yes" || answer == "no"
 		if answer == "yes"
 			client_info[:has_pets] = true
 			puts ""
 		end
 	else 
 		puts "please answer yes or no"
 	end
 end	
  puts ""
puts "How many children do you have?"
a4 = gets.chomp
temp = a4.to_i
until temp > 0 || a4 == "0"
 	 puts "Please write your answer with numbers"
  	 a4 = gets.chomp
  	 temp = a4.to_i
end
client_info[:number_children] = temp
 puts ""
puts "What would you like to be the main theme of the design?"
client_info[:decor_theme] = gets.chomp
puts client_info[:decor_theme] + "? That sounds positively lovely!"
puts ""
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
puts ""
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
puts ""
puts "Now that we know your goal budget, do you plan on making any renovations that would require a contractor? "
puts "please answer yes or no."
 a8 = nil
 until a8 == "yes" || a8 == "no"
 	a8 = gets.chomp
 	if a8 == "yes" || a8 == "no"
 		if a8 == "yes"
 			puts "I like your style"
 			client_info[:wants_contractor] = true
 		else
 			puts "That's a great and frugal decision."
 		end
 	else 
 		puts "please answer yes or no"
 	end
 end
puts ""
puts "Alright, one last question and then we'll be all set to start designing"
puts "What is your favorite color?"
client_info[:fav_color] = gets.chomp.capitalize
puts ""
puts "Before you go please review the information you have provided and if there is anything that needs changing, please type in the key, press enter, then the value you would like to correct and press enter again."
p client_info
puts ""
key =  gets.chomp.to_sym
value = gets.chomp
client_info[key] = value
puts ""
puts "Alright we have everything we need. Thanks so much for choosing Star Interior Decorators!"