require_relative'project_class'
$project = nil

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
        tables = $project.get_tables
        has_tables = !tables.empty?
        if !has_tables
                puts "Looks like you've got an empty database. Let's create a table for it!"
                puts "Please enter the name of your first table"
                table_name = get_valid_name
                $project.create_table(table_name)
        end
        puts = "\n please input the number of the option you'd like to perform"
        menu_items.each_with_index{|item, index| puts "#{index + 1}. #{item}"}
        while true
               menu_choice = gets.chomp
               break if is_number?(menu_choice) && menu_choice.to_i.between(1,menu_items.length)
               puts "Please input the number of the menu item you'd like to access"
        end
        menu_methods = ["create_new_table","access_table", "print_joined","choose_database", "exit"]
        send(menu_methods[menu_choice - 1])
end

def exit
        5.times(puts '')
        puts "Thanks for using Database Manager!"
end

choose_database