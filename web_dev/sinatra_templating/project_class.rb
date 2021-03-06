require "sqlite3"
DATA_TYPES = ['numbers','letters','true/false']

class Project

 def initialize(project_name)
        @db = SQLite3::Database.new("#{project_name}.db")
        @db.results_as_hash = true
 end

#creates a table in the given database
#adds columns and foreign keys based on user input
 def create_table(table)
        if get_tables.include?(table)
                puts "#{table} already exists."
        else
               create_table_cmd = <<-SQL
                       CREATE TABLE IF NOT EXISTS #{table}(
                              id INTEGER PRIMARY KEY
                              SQL
               puts "The table \'#{table}\' is now being created."
               puts "Let's create the first column!"
               while true
                       create_table_cmd = add_column(create_table_cmd)
                       puts "would you like to add another column?"
                       break if get_response == 'no'
               end
               puts "Would you like to add a column that references another table?"
               create_table_cmd = add_foreign_keys(create_table_cmd, table) if get_response == 'yes'
               create_table_cmd += ");"
               @db.execute(create_table_cmd)
               puts "The table #{table} has been created."
        end
 end

#deletes a table based on user input from UI
#won't delete if referenced by another table
 def delete_table(table)
        referenced_by = references(table)
        if !referenced_by.empty?
               puts "unable to delete table \'#{table}\' because it is referenced by table(s):"
               referenced_by.each{|table_name| puts "#{table_name}"}
               false
        elsif table_exists?(table)
               delete_table_cmd =  "DROP TABLE IF EXISTS #{table}"
               @db.execute(delete_table_cmd)
               puts "#{table} was deleted"
               true
        end
 end

#creates a line in a table given by the UI
#all values are given by the user
#if foreign key, match id to the necessary table
 def create_line_item(table)
        values = []
        if table_exists?(table)
               columns = get_column_names(table)[1..-1]
               insert = Array.new(columns).fill('?').join(", ")
               get_data_types(table).each_with_index do |type, i|
                       prefix = nil
                       prefix = columns[i].split('_id').join if /[_id]$/.match(columns[i])
                       if !get_tables.include? prefix
                              values << get_number(columns[i]) if type == 'INTEGER' || type == 'INT'
                              values << get_string(columns[i]) if type == 'VARCHAR(255)'
                              values << get_boolean(columns[i]) if type == 'BOOLEAN'
                       else
                              puts "#{columns[i]} references table #{prefix}"
                              puts "would you like to see that table now?"
                              print_table(prefix) if get_response == 'yes'
                              puts "would you like to reference one of the available lines?"
                              response = get_response
                              if response == 'no' || get_ids(prefix).empty?
                                     puts "That table has no lines to reference. We'll have to make a new one." if response == 'yes'
                                     puts "Alright! We will now create a new line for you to reference"
                                     create_line_item(prefix)
                                     values << get_ids(prefix)[-1]
                              else 
                                     puts "Alright! Please input the id of the line you'd like to reference"
                                     values << get_valid_id(prefix)
                              end
                       end
               end
        @db.execute("INSERT INTO #{table} (#{columns.join(", ")}) VALUES (#{insert})", values)
        end
 end

#deletes line from given table based on that line's id
def delete_line_item(table)
        if table_exists?(table)
                print_table(table)
                puts "please choose the id number of the line you'd like to delete."
                id = get_valid_id(table)
                delete = ("DELETE FROM #{table} WHERE id = #{id}")
                @db.execute(delete)
        end
 end

#returns an array filled with tables of the database
 def get_tables
        table_names = []
        tables = @db.execute <<-SQL
                 SELECT name FROM sqlite_master
                 WHERE type='table'
                 ORDER BY name;
                 SQL
        tables.each do |row| 
                table_names << row["name"]
         end
         table_names
 end

#prints names of all tables in database
 def print_table_names
        get_tables.each do |name| 
               print  "#{name} "
        end
        puts ""
 end

#prints all the info in the current table
 def print_table(table)
        if table_exists?(table)
                names = get_column_names(table)
                puts names.join("|")
                table_info = @db.execute("SELECT * FROM #{table}")
                print_execute(table_info)
         end
 end

#prints names of all of the columns of a user given table
 def print_column_names(table_name)
        if table_exists?(table_name)
                puts "Your table \"#{table_name}\" has columns named:"
                columns = get_column_names(table_name)
                columns.each_with_index do |name, i|
                        print "\"#{name}\" "
                        print "& " unless i == (columns.size - 1)
                end
                puts ""
        end
 end

#returns an array of all column names of a given table
 def get_column_names(table_name)
        column_names = get_info(table_name, 'name')
 end

#returns an array of all data types of columns of a given table not including the id key
 def get_data_types(table_name) 
        data_types = get_info(table_name, 'type')
        data_types.shift
        data_types
 end

#prints joined version of 2 tables chosen by user
#prints error message if tables don't reference each other
 def print_join
        if get_tables.size < 2
                  puts "you do not have enough tables to join"
                  return nil
        end
        to_join = []
        puts "choose 2 of these tables to join"
        print_table_names
        until to_join.length == 2
                puts "what is your first table you would like to join?" if to_join.length == 0
                puts "what is your second table you would like to join?" if to_join.length == 1
               answer = gets.chomp
               to_join << answer if table_exists?(answer)
        end
        if references(to_join[1]).include?(to_join[0])
               execute = @db.execute("SELECT * FROM #{to_join[0]} JOIN #{to_join[1]}
                       ON #{to_join[0]}.#{to_join[1]}_id = #{to_join[1]}.id ;")
               print_execute_titles(execute)
               print_execute(execute)
        elsif references(to_join[0]).include?(to_join[1])
                execute = @db.execute("SELECT * FROM #{to_join[1]} JOIN #{to_join[0]}
                       ON #{to_join[1]}.#{to_join[0]}_id = #{to_join[0]}.id ;")
                print_execute_titles(execute)
                print_execute(execute)
        else
                puts "Those two tables are incompatible and cannot be joined"
       end
 end

 private                                                                                       

#submethod that parses sql data to print only the values
 def print_execute(execute)
        execute.each do |line|
                line_info = []
                line.each do |name, value|
                       if name.is_a? String
                              line_info << value
                       end
               end
               puts line_info.join("|")
        end
 end

#submethod that parses sql data to print only the column names 
 def print_execute_titles(execute)
        execute.each do |line|
                titles = []
                line.each do |name, value|
                       if name.is_a? String
                              titles << name
                       end
               end
               puts titles.join("|")
        end
end

#submethod to determine if a given table currently exists
 def table_exists? (table_name)
        if !get_tables.include? (table_name)
               puts "the current database doesn't include a table called \"#{table_name}\""
               return false
        end
        true
 end

#submethod that parses sql data to return array of data of a given type
 def get_info(table_name, type)
        info = []
        if table_exists?(table_name)
               table_info = @db.execute("PRAGMA table_info(#{table_name});")
               table_info.each { |data| info<< data[type]}
         end 
        info
 end

#submethod to add a column to a new table
#name and datatype of the column are determined by user input
#returns sql text that would add the column
 def add_column(create_table_cmd)
        puts"what would you like the value in this column to be called?"
        column_name = get_valid_name
        puts "what type of data would you like stored in this column #{DATA_TYPES}"
        data_type = get_valid_data_type
        variable = 'VARCHAR(255)' if data_type == 'letters'
        variable = 'INT' if data_type == 'numbers'
        variable = 'BOOLEAN' if data_type == 'true/false'
        create_table_cmd += ",  #{column_name}  #{variable}"
 end

#submethod to add reference(s) to other tables
#shows users other tables that can be referenced 
#gives option to create a table if user wants to reference a non-existent one
#determines which reference to add based on user input
#returns sql text that would add the reference(s)
 def add_foreign_keys(create_table_cmd, current_table)
        foreign_keys = []
        puts "you currently have #{get_tables.length} other table(s)"
        while true
               made_reference = true
               puts "these are your current other tables:"
               print_table_names
               puts "what table would you like to refer to?"
               reference_table = get_valid_name
               if foreign_keys.include? reference_table
                       puts "#{reference_table} is already referenced by this table."
                       made_reference = false
               elsif !get_tables.include? reference_table
                       puts "that table is not in the list. would you like to create it as a table?"
                       if get_response == 'yes'
                              create_table(reference_table)
                              5.times {puts ''}
                       else
                                made_reference = false
                       end
               end
               if made_reference
                       puts "A reference to table '#{reference_table}' has been added."
                       foreign_keys << reference_table
               end
               puts "would you like to connect #{current_table} to a different table?"
               break if get_response == 'no'
        end
        foreign_keys.each {|table_name| create_table_cmd += ",  #{table_name}_id  INT"}
        foreign_keys.each {|table_name| create_table_cmd += ", FOREIGN KEY  (#{table_name}_id)  REFERENCES #{table_name}(id)"}
        create_table_cmd
 end

#returns an array of all other tables that reference the given table
 def references(current_table)
        references = []
        tables = get_tables
        tables.each do |table|
                columns = get_column_names(table)
                columns.each do |column|
                       if /[_id]$/.match(column)
                              references << table if column.split('_id').join == current_table
                       end
                end
        end
        references
 end

#prompts the user for a yes or no and won't accept any other answer
#returns the yes or no
 def get_response
        response = ''
        until response == 'yes' || response == 'no'
               puts "please answer yes or no."
               response = gets.chomp
        end
        response
 end

#prompts the user for an int and won't accept any other answer
#references the name of the column the number is for
#returns an int
 def get_number(value_name)
        puts "please input a value for #{value_name} (numbers)"
        while true
                answer=gets.chomp
                break if is_number?(answer)
                puts "please input only numbers for this value"
        end
         answer.to_i
 end

#determines if a string is a number value
#returns boolean
 def is_number?(answer)
        answer.to_i != 0 || answer == '0'
 end

#prompts the user for an string and won't accept a blank answer
#references the name of the column the string is for
#returns a string
 def get_string(value_name)
        puts "please input a value for #{value_name} (letters)"
        answer = gets.chomp
        while answer.strip.empty?
                puts "Please don't leave this value blank"
                answer = gets.chomp
        end
        answer
 end

#prompts the user for a boolean and won't accept any other answer
#references the name of the column the boolean is for
#returns a boolean
 def get_boolean(value_name)
        puts "please input a value for #{value_name} (true/false)"
        answer = gets.chomp
        until answer == 'true' || answer == 'false'
                puts "please input either true or false for this value"
                answer = gets.chomp
        end
        answer
 end

#returns an array of all ids from a given table
 def get_ids(table)
        valid_ids = []
         table_info = @db.execute("SELECT * FROM #{table}")
         table_info.each do |line|
                line_info = []
                line.each do |name, value|
                       if  name == 'id'
                               valid_ids << value
                       end
               end
        end
        valid_ids
 end

#prompts user for a value that is a valid id
#returns that id
 def get_valid_id(table)
        answer = gets.chomp
        ids = get_ids(table)
        until is_number?(answer) && ids.include?(answer.to_i)
               if !is_number?(answer)
                        puts "please enter a number"
               else
                        puts "please enter a valid id number"
               end
               answer = gets.chomp
        end
        answer
 end     

#prompts user for a string that can be used as a name and won't accept anything else
#returns that name
 def get_valid_name
        while true 
                name = gets.chomp
                break if valid_name(name)
                puts "Please only use letters, numbers or '_' in your name"
        end
        name
 end

#determines if a string is a valid name
 def valid_name (name)
        /^\w+$/.match (name)
 end

#prompts user for a string that can be used as a data type and won't accept anything else
#returns that data type
 def get_valid_data_type
        while true 
                data_type = gets.chomp
                break if DATA_TYPES.include? data_type
                puts "please choose one of the three listed data types. #{DATA_TYPES}"
        end
        data_type
 end

end