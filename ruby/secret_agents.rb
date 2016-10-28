def encrypt(secret)
	for i in 0...secret.length
		temp = secret[i]
		if temp == "z"
			temp = "a"
		else
			temp = temp.next
		end
		secret[i] = temp
	end
return secret
end

def decrypt(secret)
alphabet = "abcdefghijklmnopqrstuvwxyz"
	for i in 0...secret.length
		num = alphabet.index(secret[i])
		num -= 1
		secret[i] = alphabet[num]
	end
return secret
end

puts "Would you like to encrypt or decrypt your password?"
answer = gets.chomp
puts "Please input your code."
code = gets.chomp
if answer == "encrypt"
	puts encrypt(code)
elsif answer == "decrypt"
	puts decrypt(code)
else
	puts "Please answer \"encrypt\" or \"decrypt\""
end