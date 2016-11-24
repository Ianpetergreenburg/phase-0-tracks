require "faker"
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
                       id INTEGER PRIMARY KEY,
                       project VARCHAR(255),
                       version VARCHAR(255)
                  );
SQL
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
  delete = ("DELETE FROM #{table} WHERE id = #{id}")
  @db.execute(delete)
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

end
