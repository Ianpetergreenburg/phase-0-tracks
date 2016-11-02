def search (arr, search_term)
arr.length.times do |x|
	if arr[x] == search_term
		return x 
	end
end
return nil
end

def fib (num)
	if num == 1 
		return [0]
	elsif num == 2 
		return [0,1]
	elsif num >= 3
		num -= 2 
		arr = [0,1]
		num.times {|x| arr << arr[-1] + arr[-2]}
		return arr	
	else
		return nil
	end
end