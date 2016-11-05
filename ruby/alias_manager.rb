def codename(real_name)
#initalize a string of vowels and consonants
vowels = "aeiou"
consonants = "bcdfghjklmnpqrstvxz"
#switch first and last name and make lowercase
arr = real_name.split(' ')
arr = arr.reverse()
switch_real = arr.join(' ').downcase
#iterate through the switched name
switch_real.length().times do |i| 
	temp = switch_real[i]
#check if current letter is a vowel or consonant
	if vowels.include? temp
#either move letter forward one in vowels string/edgecase
		num = vowels.index(temp)
		if num == vowels.length() - 1 
			num = 0
		else
			num += 1 
		end
		switch_real[i] = vowels[num]
	elsif consonants.include? temp
#or move letter forward one in consonants string/edgecase
		num = consonants.index(temp)
		if num == consonants.length() - 1 
			num = 0
		else
			num += 1 
		end
		switch_real[i] = consonants[num]
	end
end
#Then recapitalize name
code_name = switch_real.split(' ').map! {|x| x.capitalize}.join(' ')
return code_name
end

#initalize database and blank answer
alias_database = {}
answer = "space"
until answer.empty? || answer == "quit"
#ask user for first and last name or quit
	puts "Please input first and last name to aquire alias. If you don't need another alias type quit or just leave your answer blank."
	answer = gets.chomp
#if they don't quit get codename and put into database
	if (not answer.empty?) && answer != "quit"
		code = codename(answer)
		alias_database.store(answer,code)
	end
end

#print out codename messages and the database
if not alias_database.empty?
	alias_database.each{|key, value| puts key + " will now be referred to as " + value}
end