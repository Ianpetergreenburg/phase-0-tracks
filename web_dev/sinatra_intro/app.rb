# require gems
require 'sinatra'
require "sinatra/reloader" if development?
require 'sqlite3'

db = SQLite3::Database.new("students.db")
db.results_as_hash = true

# write a basic GET route
# add a query parameter
# GET /
get '/' do
  "#{params[:name]} is #{params[:age]} years old."
end

# write a GET route with
# route parameters
get '/about/:person' do
  person = params[:person]
  "#{person} is a programmer, and #{person} is learning Sinatra."
end

get '/:person_1/loves/:person_2' do
  "#{params[:person_1]} loves #{params[:person_2]}"
end

# write a GET route that retrieves
# all student data
get '/students' do
  students = db.execute("SELECT * FROM students")
  response = ""
  students.each do |student|
    response << "ID: #{student['id']}<br>"
    response << "Name: #{student['name']}<br>"
    response << "Age: #{student['age']}<br>"
    response << "Campus: #{student['campus']}<br><br>"
  end
  response
end

# write a GET route that retrieves
# a particular student

get '/students/:id' do
  student = db.execute("SELECT * FROM students WHERE id=?", [params[:id]])
  student.to_s
end

get '/contact' do
    "83 S King St #250, Seattle, WA 98104"
end

get '/great_job' do
       if params.empty? 
          "Good Job!"
      else
          "Good Job, " + params["name"] + "!"
      end
end

get '/:number1/plus/:number2' do
      (params[:number1].to_i + params[:number2] .to_i).to_s
end

get '/search/:query_type/:query' do
      query_type = params[:query_type]
      query = params[:query]
       students = db.execute("SELECT * FROM students WHERE #{query_type}=?", query)
       response = ''
      students.each do |student|
                response << ("Student is " + student["name"] + '. They are ' + student["age"].to_s + " years old. <br>")
                response << ("They are attending DBC in " + student["campus"] + ".<br><br>")
       end
       response
end