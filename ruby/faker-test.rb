require 'faker'
#require 'libhunspell'
require 'ffi'
require 'hunspell-ffi'

# dict = Hunspell.new("C:/Rails Installer/Hunspell/", "en_US")
# p dict.spell("walked")
puts Faker::Hipster.sentence(6)