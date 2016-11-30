require_relative'project_class'
$project = Project.new("my_first_database")

#introduces user and prompts them to choose a database
def start
        puts "Welcome to the Database Manager!"
        puts "Please choose the database you'd like to work on first."
        5.times{puts ""}
        choose_database
end

#prompts the user to choose a database from the local directory
#prints all existing databases
#user can either choose an existing database or create a new one
# if there are no databases, user will automatically have to create a new one
#once a database is chosen user goes to the menu for that database
def choose_database
        databases = []
        database_chosen = false
        Dir.entries(".").each{|file| databases << file.split(".db").join if /.db$/.match(file)}
        puts "These databases are currently in your directory:"
        if !databases.empty?
                databases.each{|db| puts "-----     #{db}"} 
                puts "would you like to work on one of the existing databases?"
                if get_response == 'yes'
                       puts "please choose one of the listed database(s)."
                       while true
                              databases.each_with_index{|item, index| puts "#{index + 1}. #{item}"}
                              db_choice = gets.chomp.to_i
                              database = databases[db_choice - 1]
                              break if  db_choice.between?(1,databases.length)
                              puts "Please input the number of the database you'd like to access"
                       end
                       database_chosen = true
               end
        else
                puts "-----Your directory currently has no databases!"
        end
        unless database_chosen
               puts "Please the enter the name of the new database you would like to create:"
               database = get_valid_name
        end
        $project = Project.new("#{database}")
        puts "Alright! Now we are working on the database: \"#{database}\"\n\n"
        menu
end

#prompts user to do something with their database
#either complete the command the user wants or exits the program
#if there are no existing tables in the database user is automatically prompted to make one
def menu
        menu_items = ["create new table", "access table", "print joined tables","access different database","exit" ]
        menu_methods = ["create_new_table","choose_table", "print_joined","choose_database", "exit"]
        tables = $project.get_tables
        has_tables = !tables.empty?
        if !has_tables
                puts "Looks like you've got an empty database. Let's create a table for it!"
                puts "Please enter the name of your first table"
                table_name = get_valid_name
                $project.create_table(table_name)
        end
        menu_choice = menu_chooser(menu_items)
        send(menu_methods[menu_choice.to_i - 1])
end

#creates a new table in the database
def create_new_table
        puts "Please enter the name of the table you'd like to create"
        table_name = get_valid_name
        $project.create_table(table_name)
        menu
end

#prompts user to choose an existing table
#moves the user to the menu for that table
def choose_table
        tables = $project.get_tables
        puts "These are you current tables:"
        $project.print_table_names
        puts "which table would you like to access"
        tables.each_with_index{|item, index| puts "#{index + 1}. #{item}"}
        while true
               table_choice = gets.chomp.to_i
               break if  table_choice.between?(1,tables.length)
               puts "Please input the number of the table you'd like to access"
        end
        access_table(tables[table_choice - 1])
end

#prompts user to do something with their table
#if simple, complete the command and return to the table menu
#if add or delete loop the command as prompted to add many items at once
#make sure the user actually want to delete a table if that command is selected, if so return to main menu afterwards
#choose table shouldn't return to menu after completed
def access_table(table)
        menu_items = ["print table", "print column names", "add item to table", "delete item from table", "delete table", "access a different table", "return to menu"]
        puts "You are now accessing table \'#{table}\'"
        puts "Choose what you would like to do with this table"
        menu_choice = menu_chooser(menu_items)
        simple_items = [1,2,6]
        if simple_items.include? menu_choice
                $project.print_table(table) if menu_choice == 1
                $project.print_column_names(table) if menu_choice == 2
                choose_table if menu_choice == 6
        elsif  menu_choice == 3
                while true
                        $project.create_line_item(table)
                        puts "would you like to add another line to  \'#{table}\'?"
                        break if get_response == 'no'
                end
        elsif menu_choice == 4
               while true
                        $project.delete_line_item(table)
                        puts "would you like to delete another line from \'#{table}\'?"
                        break if get_response == 'no'
                end
        elsif menu_choice == 5
                        puts "are you sure that you would like to delete this table?"
                        if get_response == 'yes'
                              menu_choice = 7 if $project.delete_table(table)
                        end
        end
        access_table(table) unless menu_choice > 5
        menu unless menu_choice != 7
end

#prints joined version of two tables
def print_joined
        $project.print_join
        menu
end

#exits the program
#bids the user farewell
def exit
        5.times{puts ''}
        puts "Thanks for using Database Manager!"
end

#submethod to get user input to choose an option from a menu array
#returns int indicating their choice
def menu_chooser(menu_items)
        puts "\n please input the number of the option you'd like to perform"
        menu_items.each_with_index{|item, index| puts "#{index + 1}. #{item}"}
        while true
               menu_choice = gets.chomp
               break if is_number?(menu_choice) && menu_choice.to_i.between?(1,menu_items.length)
               puts "Please input the number of the menu item you'd like to access"
        end
        menu_choice.to_i
end

#submethod to get yes or no answer from user
#returns yes or no 
def get_response
  response = ''
  until response == 'yes' || response == 'no'
         puts "please answer yes or no."
         response = gets.chomp
  end
  response
end

#submethod to determine if a string is valid for a name
#returns boolean
def valid_name (name)
        /^\w+$/.match (name)
end

#submethod to get a string from a user that is a valid name
#returns a valid name
def get_valid_name
        while true 
               name = gets.chomp
               break if valid_name(name)
               puts "Please only use letters, numbers or '_' in your name"
        end 
        name    
end

#submethod to determine if a string is a number
#returns boolean
 def is_number?(answer)
        answer.to_i != 0 || answer == '0'
 end

start