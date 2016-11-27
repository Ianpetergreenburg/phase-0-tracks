require "sqlite3"

class Project

 def initialize(project_name)
        @db = SQLite3::Database.new("#{project_name}.db")
        @db.results_as_hash = true
 end

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

 def delete_table(table)
        referenced_by = references(table)
        if !referenced_by.empty?
               puts "unable to delete table \'#{table}\' because it is referenced by table(s):"
               referenced_by.each{|table_name| puts "#{table_name}"}
        elsif table_exists?(table)
               delete_table_cmd =  "DROP TABLE IF EXISTS #{table}"
               @db.execute(delete_table_cmd)
               puts "#{table} was deleted"
        end
 end

 def create_line_item(table)
        values = []
        if table_exists?(table)
               columns = get_column_names(table)[1..-1]
               insert = Array.new(columns).fill('?').join(", ")
               get_data_types(table).each_with_index do |type, i|
                       prefix = nil
                       prefix = columns[i].split('_id').join if /[_id]$/.match(columns[i])
                       if !get_tables.include? prefix
                              values << get_int(columns[i]) if type == 'INTEGER'
                              values << get_string(columns[i]) if type == 'VARCHAR(255)'
                              values << get_boolean(columns[i]) if type == 'BOOLEAN'
                       else
                              puts "#{columns[i]} references table #{prefix}"
                              puts "would you like to see that table now?"
                              print_table(prefix) if get_response == 'yes'
                              puts "would you like to reference one of the available lines?"
                              if get_response == 'no'
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

def delete_line_item(table)
        if table_exists?(table)
                print_table(table)
                puts "please choose the id number of the line you'd like to delete."
                id = get_valid_id(table)
                delete = ("DELETE FROM #{table} WHERE id = #{id}")
                @db.execute(delete)
        end
 end

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

 def print_table_names
        get_tables.each do |name| 
               print  "#{name} "
        end
        puts ""
 end

 def print_table(table)
        if table_exists?(table)
                names = get_column_names(table)
                puts names.join("|")
                table_info = @db.execute("SELECT * FROM #{table}")
                print_execute(table_info)
         end
 end

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

 def get_column_names(table_name)
        column_names = get_info(table_name, 'name')
 end

 def get_data_types(table_name) 
        data_types = get_info(table_name, 'type')
        data_types.shift
        data_types
 end

 def print_join
        to_join = []
        puts "choose 2 of these tables to join"
        print_table_names
        until to_join.length == 2 #&& answer == 'exit'
                puts "what is your first table you would like to join?" if to_join.length == 0
                puts "what is your second table you would like to join?" if to_join.length == 1
               answer = gets.chomp
               to_join << answer if table_exists?(answer)
        end
        if references(to_join[1]).include?(to_join[0])
               print_execute(@db.execute("SELECT * FROM #{to_join[0]} JOIN #{to_join[1]}
                       ON #{to_join[0]}.#{to_join[1]}_id = #{to_join[1]}.id ;"))
        elsif references(to_join[0]).include?(to_join[1])
                print_execute(@db.execute("SELECT * FROM #{to_join[1]} JOIN #{to_join[0]}
                       ON #{to_join[1]}.#{to_join[0]}_id = #{to_join[0]}.id ;"))
        else
                puts "Those two tables are incompatible and cannot be joined"
       end
 end

#private

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

 def table_exists? (table_name)
        if !get_tables.include? (table_name)
               puts "the current database doesn't include a table called \"#{table_name}\""
               return false
        end
        true
 end

def get_info(table_name, type)
        info = []
        if table_exists?(table_name)
               table_info = @db.execute("PRAGMA table_info(#{table_name});")
               table_info.each { |data| info<< data[type]}
         end 
        info
 end

 def add_column(create_table_cmd)
        puts"what would you like the value in this column to be called?"
        column_name = get_valid_name
        data_type = get_valid_data_type
        variable = 'VARCHAR(255)' if data_type == 'letters'
        variable = 'INT' if data_type == 'numbers'
        variable = 'BOOLEAN' if data_type == 'true/false'
        create_table_cmd += ",  #{column_name}  #{variable}"
 end


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

 def get_response
        response = ''
        until response == 'yes' || response == 'no'
               puts "please answer yes or no."
               response = gets.chomp
        end
        response
 end

 def get_number(value_name)
        puts "please input a value for #{value_name} (numbers)"
        while true
                answer=gets.chomp
                break if is_number?(answer)
                puts "please input only numbers for this value"
        end
         answer.to_i
 end

 def is_number?(answer)
        answer.to_i != 0 || answer == '0'
 end

 def get_string(value_name)
        puts "please input a value for #{value_name} (letters)"
        answer = gets.chomp
        while answer.strip.empty?
                puts "Please don't leave this value blank"
                answer = gets.chomp
        end
        answer
 end

 def get_boolean(value_name)
        puts "please input a value for #{value_name} (true/false)"
        answer = gets.chomp
        until answer == 'true' || answer == 'false'
                puts "please input either true or false for this value"
                answer = gets.chomp
        end
        answer
 end

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

 def get_valid_name
        while true 
                name = gets.chomp
                break if valid_name(name)
                puts "Please only use letters, numbers or '_' in your name"
        end
        name
 end

 def valid_name (name)
        /^\w+$/.match (name)
 end

 def get_valid_data_type
        while true 
                data_type = gets.chomp
                break if valid_data_type(data_type)
                puts "please choose one of the three listed data types. #{data_types}"
        end
        data_type
 end

 def valid_data_type(data_type)
        data_types = ['numbers','letters','true/false']
        data_types.include? data_type
 end

end