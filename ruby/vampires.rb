puts "How many employee's will be taking the survey?"
employee = gets.chomp.to_i
for i in 1..employee
	puts "What is your name?"
	name = gets.chomp
	puts "How old will you be at the end of this year?"
	age = gets.chomp.to_i
	puts "What year were you born?"
	birth_year = gets.chomp.to_i
	real_age = 2016 - birth_year
	puts "Would you like some garlic bread? (yes/no)"
	garlic_bread = gets.chomp
	puts "Would you like to enroll in the company health insurance? (yes/no)"
	health_ins = gets.chomp
	puts "Please list all allergies. Enter done when you have listed all."
	allergy = nil
	until allergy == "done" || allergy == "sunshine"
		allergy = gets.chomp
	end
	if allergy == "sunshine"
		puts "Probably a vampire."
	elsif name == "Drake Cula" || name == "Tu Fang"
		puts "Definitely a vampire."
	elsif real_age == age && (garlic_bread == "yes" || health_ins == "yes")
		puts "Probably not a vampire."
	elsif real_age != age && garlic_bread == "no" && health_ins == "no"
		puts "Almost certainly a vampire."
	elsif real_age != age && (garlic_bread == "no" || health_ins == "no")
		puts "Probably a vampire."
	else
		puts "Results inconclusive"
	end
end