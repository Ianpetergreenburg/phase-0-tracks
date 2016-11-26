require "faker"
require "sqlite3"

class Project

  def initialize(project_name)
        @db = SQLite3::Database.new("#{project_name}.db")
        @db.results_as_hash = true
  end

def get_response
  response = ''
  until response == 'yes' || response == 'no'
         puts "please answer yes or no."
         response = gets.chomp
  end
  response
end

def add_column(create_table_cmd)
 data_types = ['numbers','letters','true/false']
         puts"what would you like the value in this column to be called?"
         column_name = gets.chomp
         puts "What type of data would you like stored? #{data_types}"
         data_type = gets.chomp
         until data_types.include? data_type
                 puts "please choose one of the three listed data types. #{data_types}"
                data_type = gets.chomp
          end
          variable = 'VARCHAR(255)' if data_type == data_types[0]
          variable = 'INT' if data_type == data_types[1]
          variable = 'BOOLEAN' if data_type == data_types[2]
          create_table_cmd += ",  #{column_name}  #{variable}"
end

def add_foreign_keys(create_table_cmd)
       foreign_keys = []
               puts "you currently have #{get_tables.length} other table(s)"
                while response == 'no'
                       puts "these are your current other tables:" 
                       print_tables
                       puts "what table would you like to refer to?"
                        table_name = gets.chomp
                       if !get_tables.include? table_name
                              puts "that table is not in the list. would you like to create it as a table?"
                             if get_response == 'yes'
                                     create_table(table_name)
                                     foreign_keys << table_name
                              end
                       else
                             foreign_keys << table_name
                       end
                       puts "would you like to connect to a different table?"
                       response = get_response
                end
                foreign_keys.each {do |table_name| create_table_cmd += ",  #{table_name}_id  INT"}
                foreign_keys.each do |table_name|
                       create_table_cmd += ", FOREIGN KEY  #{table_name}_id  INT"
                end
end

def create_table(table)
  response = 'yes'
 if get_tables.include?(table)
        puts "#{table} already exists."
 else
         create_table_cmd = <<-SQL
                CREATE TABLE IF NOT EXISTS #{table}(
                       id INTEGER PRIMARY KEY
                       SQL
         puts "The table \'#{table}\' is now being created."
         puts "Let's create the first column!"
         until response == 'no'
                create_table_cmd = add_column(create_table_cmd)
                puts "would you like to add another column? (yes/no)"
                response = get_response
        end
        while response == 'no'
                puts "would you like to add a column that references another table?"
                until get_response == 'no'
                        puts "you currently have #{get_tables.length} other table(s)"
                        create_table_cmd = add_foreign_keys(create_table_cmd)
                end
        end
          create_table_cmd += ");"
         @db.execute(create_table_cmd)
         puts "the table #{table} has been created."
 end
end

def delete_table(table)
  if get_tables.include?(table)
        delete_table_cmd =  "DROP TABLE IF EXISTS #{table}"
        @db.execute(delete_table_cmd)
        puts "#{table} was deleted"
  else
        puts "That table does not exist."
   end
end

def create_line_item(project, version)
  @db.execute("INSERT INTO project (project, version) VALUES (?, ?)", [project, version])
end

def delete_line_item(table, id)
  if get_tables.include? (table) 
          delete = ("DELETE FROM #{table} WHERE id = #{id}")
          @db.execute(delete)
  else
          puts "That table does not exist"
  end
end

def get_tables
  table_names = []
  tables = @db.execute <<SQL
         SELECT name FROM sqlite_master
         WHERE type='table'
         ORDER BY name;
SQL
  tables.each do |row| 
        table_names << row["name"]
 end
 table_names
end

def print_tables
    tables = @db.execute <<SQL
         SELECT name FROM sqlite_master
         WHERE type='table'
         ORDER BY name;
SQL
  tables.each do |row| 
          puts row["name"]
   end
end

  def print_column_names(table_name)
    if !get_tables.include? table_name
          puts "the current database doesn't include a table called \"#{table_name}\""
    else
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
  column_names = []
  if !get_tables.include? (table_name)
      puts "the current database doesn't include a table called \"#{table_name}\""
  else
        column_names = []
        columns = @db.execute("PRAGMA table_info(#{table_name});")
        columns.each do |column|
               column_names<< column["name"]
        end   
  end
  column_names 
 end

end
