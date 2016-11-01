def codename(real_name)
vowels = "aeiou"
consonants = "bcdfghjklmnpqrstvxz"
arr = real_name.split(' ')
arr = arr.reverse()
switch_real = arr.join(' ').downcase
for i in 0...switch_real.length
	temp = switch_real[i]
	if vowels.include? temp
		num = vowels.index(temp)
		if num == vowels.length() - 1 
			num = 0
		else
			num += 1 
		end
		switch_real[i] = vowels[num]
	elsif consonants.include? temp
		num = consonants.index(temp)
		if num == consonants.length() - 1 
			num = 0
		else
			num += 1 
		end
		switch_real[i] = consonants[num]
	end
end
switch_real = switch_real.split(' ').map! {|x| x.capitalize}.join(' ')
return switch_real
end

alias_database = {}
answer = "space"
until answer.empty? || answer == "quit"
	puts "Please input first and last name to aquire alias. If you don't need another alias type quit or just leave your answer blank."
	answer = gets.chomp
	if (not answer.empty?) && answer != "quit"
		code = codename(answer)
		alias_database.store(answer,code)
	end
end

if not alias_database.empty?
	alias_database.each{|key, value| puts key + " will now be referred to as " + value}
end