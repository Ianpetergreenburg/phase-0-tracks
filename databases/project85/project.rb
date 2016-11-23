require "faker"
require "sqlite3"

db = SQLite3::Database.new("project.db")
db.results_as_hash = true

def create_table_cmd(table)
 create_table_cmd = <<-SQL
          CREATE TABLE IF NOT EXISTS #{table}(
               id INTEGER PRIMARY KEY,
               project VARCHAR(255),
               version VARCHAR(255)
          );
 SQL
 db.execute(create_table_cmd)
end

def delete_table_cmd(table)
 delete_table_cmd =  "DROP TABLE IF EXISTS #{table}"
 db.execute(delete_table_cmd)
end

def create_line_item(db, project, version)
  db.execute("INSERT INTO project (project, version) VALUES (?, ?)", [project, version])
end

def delete_line_item(db,table, id)
  delete = ("DELETE FROM #{table} WHERE id = #{id}")
  db.execute(delete)
end

# 10.times do
#   create_line_item(db, Faker::App.name, Faker::App.version)
# end

delete_line_item(db,project,2)

projects = db.execute("SELECT * FROM project")
projects.each do |project|
  puts "Project \##{project["id"]} is called #{project["project"]} and is currently on version #{project["version"]}"
end