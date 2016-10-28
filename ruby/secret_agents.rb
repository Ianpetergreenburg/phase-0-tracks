def encrypt(secret)
password_length = secret.length - 1
	for i in 0..password_length
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
password_length = secret.length - 1
alphabet = "abcdefghijklmnopqrstuvwxyz"
	for i in 0..password_length
		num = alphabet.index(secret[i])
		num -= 1
		secret[i] = alphabet[num]
	end
return secret
end