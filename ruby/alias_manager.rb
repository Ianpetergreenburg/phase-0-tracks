#move index forward in vowels or consonants
def nextindex(alphabet, index)
  if index == alphabet.length() - 1 
      return 0
    else
      return index + 1 
    end
end

def codename(real_name)
#initalize a string of vowels and consonants
vowels = "aeiou"
consonants = "bcdfghjklmnpqrstvwxyz"
#switch first and last name and make lowercase
arr = real_name.split(' ')
arr = arr.reverse()
switch_real = arr.join(' ').downcase
#iterate through the switched name
switch_real.length().times do |i| 
	current_letter = switch_real[i]
#check if current letter is a vowel or consonant
	if vowels.include? current_letter
#either move letter forward one in vowels string/edgecase
		current_index = vowels.index(current_letter)
               code_index = nextindex(vowels, current_index)
		switch_real[i] = vowels[code_index]
	elsif consonants.include? current_letter
#or move letter forward one in consonants string/edgecase
		current_index = consonants.index(current_letter)
               code_index = nextindex(consonants,current_index)
		switch_real[i] = consonants[code_index]
	end
end
#Then recapitalize name
code_name = switch_real.split(' ').map! {|x| x.capitalize}.join(' ')
return code_name
end

#initalize database and blank answer
alias_database = {}
answer = "blank answer"
until answer.empty? || answer == "quit"
#ask user for first and last name or quit
	puts "Please input first and last name to aquire alias."
        puts" If you don't need another alias type quit or just leave your answer blank."
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