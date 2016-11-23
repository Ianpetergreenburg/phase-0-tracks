require "faker"
require "sqlite3"

db = SQLite3::Database.new("project.db")
db.results_as_hash = true

create_table_cmd = <<-SQL
  CREATE TABLE IF NOT EXISTS project(
    id INTEGER PRIMARY KEY,
    project VARCHAR(255),
    version VARCHAR(255)
  );
SQL

delete_table_cmd = <<-SQL
  CREATE TABLE IF NOT EXISTS project(
    id INTEGER PRIMARY KEY,
    project VARCHAR(255),
    version VARCHAR(255)
  );
SQL

db.execute(create_table_cmd)

def create_line_item(db, project, version)
  db.execute("INSERT INTO project (project, version) VALUES (?, ?)", [project, version])
end

# 10.times do
#   create_line_item(db, Faker::App.name, Faker::App.version)
# end

projects = db.execute("SELECT * FROM project")
projects.each do |project|
  #p project
  puts "Project \##{project["id"]} is called #{project["project"]} and is currently on version #{project["version"]}"
end