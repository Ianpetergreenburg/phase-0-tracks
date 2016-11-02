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

#take an Array
#look at first two values 
#swap if first is bigger than second 
#look at next two values
#repeat if not at end of array
#repeat as many times as array is long - 1 
#return array 

def bubble (arr)
	flag = false
	if arr.length >= 2 
		loops =	arr.length - 1
		while true
			loops.times do |x|
				temp = arr[x]
				temp2 = arr[x + 1]
				if temp > temp2
					arr[x + 1] = temp
					arr[x] = temp2
					flag = true
				end
			end
			if !flag
				break
			end
			flag = false
		end
	end
	return arr
end