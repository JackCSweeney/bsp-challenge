require './lib/direction_manager.rb'
require './lib/input_reader.rb'
require './lib/matrix.rb'
require './lib/positionable.rb'
require './lib/princess_saver.rb'
require './lib/princess.rb'
require './lib/robot.rb'

puts "Enter which challenge mode you would like to see: 1 to print all directions or 2 to print just the next move"
mode = $stdin.gets.chomp.to_i
saver = PrincessSaver.new
statement = "Please enter an odd number between 3 - 100 and a grid matching that size in length and width.\nUse '-' to denote cells on the grid.\nPlace the robot 'm' in the center and place the princess 'p' in one of the four corners."


case mode
when 1
  puts statement
  saver.input_reader.get_matrix_size
  saver.input_reader.get_matrix_rows
  saver.make_matrix
  puts saver.directions_to_princess
when 2
  puts statement
  saver = PrincessSaver.new
  saver.input_reader.get_matrix_size
  saver.input_reader.get_robot_coordinates
  saver.input_reader.get_matrix_rows
  saver.make_matrix
  puts saver.next_move_to_save_princess
else
  puts 'Invalid option. Please enter 1 or 2.'
end