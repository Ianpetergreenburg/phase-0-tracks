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

def choose_database
        databases = []
        database_chosen = false
        Dir.entries(".").each{|file| databases << file.split(".db").join if /.db$/.match(file)}
        puts "These databases are currently in your directory"
        if !databases.empty?
                databases.each{|db| puts db} 
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
                puts "Your directory currently has no databases"
        end
        unless database_chosen
                while true 
                        puts "Please the enter the name of the new directory you would like to create:"
                        database = gets.chomp
                        break if valid_name(database)
                        puts "Please only use letters, numbers or '_' in your name"
                end
        end
        $project = Project.new("#{database}")
end
has_tables = project.get_tables.empty?
if !has_tables
        puts "Looks like you've got an empty database. Let's create a table for it!"
        puts "Please enter the name of your first table"
        table_name = gets.chomp
        project.create



puts "No"