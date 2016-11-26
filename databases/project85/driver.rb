require_relative'project_class'

project2 = Project.new("project2")

# table = "b"
#  project2.create_table(table)
#project2.print_tables
#project2.print_column_names('d')
# # project2.create_table("b")
# # puts "delete a table?"
# # table = gets.chomp
project2.delete_table("d")
# # project2.print_tables
# # project2.delete_table("b")
# project2.print_tables
# project2.print_column_names("b")
# p project2.get_column_names("c")
project2.create_table('d')


