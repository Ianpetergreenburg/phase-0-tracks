def codename(real_name)
vowels = "aeiou"
consonants = "bcdfghjklmnpqrstvxz"
arr = real_name.split(' ')
temp = arr[1]
arr[1] = arr[0]
arr[0] = temp
switch_real = arr.join(' ').downcase
puts switch_real
for i in 0...switch_real.length
	temp2 = switch_real[i]
	if vowels.include? temp2
		num = vowels.index(temp2)
		if num == vowels.length() - 1 
			num = 0
		else
			num += 1 
		end
		switch_real[i] = vowels[num]
	elsif consonants.include? temp2
		num = consonants.index(temp2)
		if num == consonants.length() - 1 
			num = 0
		else
			num += 1 
		end
		switch_real[i] = consonants[num]
	end
end
switch_real = switch_real.split(' ').map! {|x| x.capitalize}.join(' ')
puts switch_real
end

codename("Ian Peter")