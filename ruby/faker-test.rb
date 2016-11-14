# require 'faker'
# # require 'libhunspell'
# # require 'ffi'
# # require 'hunspell-ffi'
# # require 'ffi/hunspell'

# # dict = Hunspell.new("C:/Rails Installer/Hunspell/", "en_US")
# # p dict.spell("walked")
# puts Faker::Hipster.sentence(6)

class Dog
end

tests = {}
10.times do |i| 
    dog = Dog.new
    tests[dog] = "puppy"
end

puts tests