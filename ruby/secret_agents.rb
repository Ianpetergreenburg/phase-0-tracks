Encrypt
#take an argument to code
#find out the length
#traverse the length while moving one letter forward in alphabet
#return the encrypted

def encrypt(secret)
password_length = secret.length - 1
	for i in 0..password_length
		temp = secret[i]
		temp = temp.next
		secret[i] = temp
	end
return secret
end

Decrypt
#input alphabet
#take an argument to decode
#find out the length
#traverse the length while moving one letter backward in alphabet
#return the unencrypted