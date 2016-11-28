require_relative'project_class'
$project = Project.new("test_database")

def get_response
  response = ''
  until response == 'yes' || response == 'no'
         puts "please answer yes or no."
         response = gets.chomp
  end
  response
end

def valid_name (name)
        /^\w+$/.match (name)
end

def get_valid_name
        while true 
               name = gets.chomp
               break if valid_name(name)
               puts "Please only use letters, numbers or '_' in your name"
        end 
        name    
end

 def is_number?(answer)
        answer.to_i != 0 || answer == '0'
 end

def choose_database
        databases = []
        database_chosen = false
        Dir.entries(".").each{|file| databases << file.split(".db").join if /.db$/.match(file)}
        puts "These databases are currently in your directory:"
        if !databases.empty?
                databases.each{|db| puts "-----     #{db}"} 
                puts "would you like to work on one of the existing databases?"
                if get_response == 'yes'
                        while true
                               puts "please choose one of the listed database(s). #{databases}"
                               database = gets.chomp 
                               if databases.include? database
                                      database_chosen = true
                                      break 
                               end
                        end
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

def create_new_table
        puts "Please enter the name of the table you'd like to create"
        table_name = get_valid_name
        $project.create_table(table_name)
        menu
end

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
                        puts "would you like to add another line?"
                        break if get_response == 'no'
                end
        elsif menu_choice == 4
               while true
                        $project.delete_line_item(table)
                        puts "would you like to delete another line?"
                        break if get_response == 'no'
                end
        elsif menu_choice == 5
                        puts "are you sure that you would like to delete this table?"
                        if get_response == 'yes'
                              $project.delete_table(table)
                              menu_choice = 7
                        end
        end
        access_table(table) unless menu_choice == 7
        menu unless menu_choice != 7
end

def print_joined
        $project.print_join
        menu
end

def exit
        5.times{puts ''}
        puts "Thanks for using Database Manager!"
end

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

menu