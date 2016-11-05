#initialize the client info hash
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

#determine if a statement was the words yes or no
def yesorno? (statement)
	if statement == "yes" or statement == "no"
		return true
	end
	return false
end

#introduce user to program
puts "Hello. Welcome to Star Interior Decorators, where you, the client
	is the real star."
puts "Please fill out the following questions to help us get to know you."
puts ""
# get and input user name
puts "First off, what would you like us to call you?"
client_info[:name] = gets.chomp
puts "Great to meet you " + client_info[:name] + "!"
puts ""
# get and input age (make sure they use numbers)
puts "Could I also get your age?"
client_info[:age] = gets.chomp.to_i
until client_info[:age] != nil && client_info[:age] != 0
	 	puts "Please write your age in numbers"
 		client_info[:age] = gets.chomp.to_i
 end

#compliment them based on their age
 puts "You look so young for someone who's " + client_info[:age].to_s + "!"
 puts ""
 #ask about their pet status , make sure they answer yes or no
 puts "Do you have any pets? Please answer yes or no"
 a3 = nil
 until yesorno?(a3)
 	a3 = gets.chomp
 	if yesorno?(a3)
 		if a3 == "yes"
 			client_info[:has_pets] = true
 			puts ""
 		end
 	else 
 		puts "please answer yes or no"
 	end
 end	
 #check how many children they have and make sure they answer with a number 
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
 #ask for the theme
puts "What would you like to be the main theme of the design?"
client_info[:decor_theme] = gets.chomp
#compliment their theme choice
puts client_info[:decor_theme] + "? That sounds positively lovely!"
puts ""
#check their dislikes and allow them to add multiple dislikes
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
#check for their budget, make sure it is above 0
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
#check if they want a contractor and compliment their decision
#make sure they answer yes or no
puts "Now that we know your goal budget, do you plan on making any renovations that would require a contractor? "
puts "please answer yes or no."
 a8 = nil
 until yesorno?(a8)
 	a8 = gets.chomp
 	if yesorno?(a8)
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
#find out their favorite color
puts "What is your favorite color?"
client_info[:fav_color] = gets.chomp
puts ""
#print out  their info
puts "Before you go please review the information you have provided."
puts "If there is anything that needs changing, please type in the key, press enter, then the value you would like to correct and press enter again."
puts"Otherwise type none to avoid changing anything"
p client_info
puts ""
#allow them to change one of their answers
key =  gets.chomp.to_sym
if key != :none
	value = gets.chomp
	client_info[key] = value
end
#outro them
puts ""
puts "Alright we have everything we need. Thanks so much for choosing Star Interior Decorators!"