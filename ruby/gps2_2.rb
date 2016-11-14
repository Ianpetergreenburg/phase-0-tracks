list_of_groceries = "apple banana pancake cheese"
$default_quantity = 1
$grocery_list = {}

# Method to create a list
# input: string of items separated by spaces (example: "carrots apples cereal pizza")
# steps: 
  # split list to turn it into an array
  # set default quantity
  # iterate through list_array and create a new hash with each key being an item in list_array and value being the quantity (currently default)
  # print the list to the console [can you use one of your other methods here?]
# output: Hash
def make_list (list, quantity = $default_quantity)
  list_arr = list.split
  list_arr.each do |list_item|
    $grocery_list[list_item] = quantity
  end
end

make_list(list_of_groceries)

puts $grocery_list

# Method to add an item to a list
# input: item name and optional quantity
# steps: 
  #check to make sure item doesn't already exist in array
  #if it doesn't, add the new item into the list with either the default quantity or whatever quantity the user passes into the method
# output: No direct return, editing existing hash

def add_item(new_item, quantity = $default_quantity)
  if !$grocery_list.include? new_item
    $grocery_list[new_item] = quantity
  else
    puts "that item is already in your list!"
  end
end

add_item("pears", 2)
add_item("light bulbs")
add_item("apple")
add_item("cheese", 3)

puts $grocery_list

# Method to remove an item from the list
# input: item name to be removed
# steps:
 # check if item is in the hash
 # if it is, remove that key value pair
# output: No direct return, editing existing hash

def delete_item (unwanted_item)
  if $grocery_list.include? unwanted_item
    $grocery_list.delete(unwanted_item)
  else
    puts "that item already is not in your list!"
  end
end

delete_item("pears")
delete_item("chese")

puts $grocery_list
# Method to update the quantity of an item
# input: item name and quantity
# steps:
  #Check if item exists in hash
  #Update quantity if key exists
# output: No direct return, editing existing hash

def update_item (item,  new_quantity)
  if $grocery_list.include? item
    $grocery_list[item] = new_quantity
  else 
    puts "that item is not in the list!"
  end
end

update_item("banana", 5)
update_item("cucumber", 2)
update_item("apple", 0)

puts $grocery_list
# Method to print a list and make it look pretty
# input: No input
# steps: Iterate through hash and print out each key -> value pair
# output: No direct return, prints out list

def print_list
  puts "Here is your current grocery list:"
  $grocery_list.each do |item, quantity|
    puts "There are #{quantity} items of type #{item}" if quantity > 1
    puts "There is #{quantity} item of type #{item}" if quantity == 1
    puts "There is no #{item}" if quantity == 0
  end
end

print_list