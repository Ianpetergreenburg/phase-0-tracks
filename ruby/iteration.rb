def say_it (str)
	yield
    yield
    yield
end 

say_it("the string") { puts " This is the block"}

 def method_hsh(h)
 	
 	puts "Prior Value :  "
 	h.each do |key,value|
 	  puts key.to_s + " is "+ value
 	end 
 	puts "Post Value :"
 	h.each do |key,value|
 	  h[key] = "Happy"
 	  puts key.to_s + " is "+ h[key]
 	end 
 	
 	puts h
end 

def method_ar(ar)
	
	puts "Prior Value :"
	puts ar
	ar.map! do |x|
	   "Hi"
	end 
	
	puts "Post Value : "
	puts ar
end 	

def method_r(ar)
    puts "Prior Value : "
    puts ar 
    ar.each_index do |x|
       ar[x] = ar[x].next	
    end 
    
    puts "Post Value : "
    puts ar
end 
 
 arr = ["a","b","c"]
 
 hsh = {bradpitt: "single", cameron: "single" , charlie: "divorced"}
 
 method_r(arr)
 method_hsh (hsh)
 method_ar(arr)


 arr = [3,4,8,12,16]
p " Array : .delete_if method"
p arr
arr.delete_if {|value| value < 5}
p arr
puts "............................"

arr = [3,4,8,12,16]
p " Array : .reject method "
p arr 
arr.reject! {|value| value < 5 }
p arr
puts "............................"


arr = [3,4,8,12,16]
p " Array : .keep_if method"
p arr
arr.keep_if {|value| value < 5}
p arr
puts "............................"

arr = [3,4,8,12,16]
p " Array : .select method "
p arr
arr.select! {|value| value < 5 }
p arr
puts "............................"

arr = [3,4,8,12,16]
p " Array : .drop_while "
p arr
arr = arr.drop_while {|value| value < 5 }
p arr 
p "............................"

hsh = {a: 3, b: 4, c: 8, d: 12, e: 16}
p "Hash : .delete_if"
p hsh
hsh.delete_if {|key,value| value < 5}
p hsh
puts "............................"

hsh = {a: 3, b: 4, c: 8, d: 12, e: 16}
p "Hash : .keep_if"
p hsh
hsh.keep_if {|key,value| value < 5}
p hsh
puts "............................"

hsh = {a: 3, b: 4, c: 8, d: 12, e: 16}
p "Hash : .select"
p hsh
hsh.select! {|key,value| value < 5}
p hsh
puts "............................"

hsh = {a: 3, b: 4, c: 8, d: 12, e: 16}
p "Hash : .reject"
p hsh
hsh.reject! {|key,value| value < 5}
p hsh
puts "............................"