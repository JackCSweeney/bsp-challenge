module Positionable
  attr_reader :coordinates
  
  def initialize(x:, y:)
    @coordinates = {x: x, y: y}
  end

  def move_on_x_axis(amount)
    @coordinates[:x] += amount
  end

  def move_on_y_axis(amount)
    @coordinates[:y] += amount
  end
end

class Princess
  include Positionable
end

class Robot
  include Positionable
  attr_reader :directions

  def directions_to_princess(princess_coordinates)
    @directions = DirectionManager.new(coordinates, princess_coordinates).calculate_directions
  end

  def next_move
    next_direction = @directions.shift
    move_value = ["UP", "RIGHT"].include?(next_direction) ? 1 : -1
    move_on_x_axis(move_value) if next_direction == "LEFT" || next_direction == "RIGHT"
    move_on_y_axis(move_value) if next_direction == "UP" || next_direction == "DOWN"
    next_direction
  end
end

class DirectionManager
  attr_reader :directions
  
  def initialize(start, target)
    @start = start
    @target = target
    @directions = []
  end

  def calculate_directions
    x_axis_directions
    y_axis_directions
    @directions
  end

  def x_axis_directions
    distance = @start[:x] - @target[:x]
    move = distance.positive? ? 'LEFT' : 'RIGHT'
    distance.abs.times { @directions << move }
  end

  def y_axis_directions
    distance = @start[:y] - @target[:y]
    move = distance.positive? ? 'UP' : 'DOWN'
    distance.abs.times { @directions << move }
  end
end

class Matrix
  attr_reader :size, :grid, :robot, :princess

  def initialize(size, rows, robot_coordinates={})
    @size = size
    @grid = rows.map(&:chars)
    @robot = Robot.new(**coordinates_for_robot(robot_coordinates))
    @princess = Princess.new(**coordinates_for_princess)
  end

  def coordinates_for_princess
    grid.flatten.each_with_index do |cell, index|
      return {x: (index % @size), y: (index / @size)} if cell == 'p'
    end
  end

  def coordinates_for_robot(provided_coordinates)
    return provided_coordinates if provided_coordinates[:x] && provided_coordinates[:y]
    {x: (size / 2), y: (size / 2)}
  end
end

class InputReader
  attr_reader :size, :matrix_rows, :robot_coordinates

  def initialize
    @size = 0
    @matrix_rows = []
    @robot_coordinates = {}
  end

  def get_matrix_size
    non_validated_size = $stdin.gets.to_i
    @size = validate_size_input(non_validated_size)
  end
  
  def get_matrix_rows
    non_validated_rows = []
    size.times {non_validated_rows << $stdin.gets.chomp}
    @matrix_rows = validate_row_input(non_validated_rows)
  end

  def get_robot_coordinates
    input = $stdin.gets
    if /[[:digit:]]/.match(input)
      non_validated_coordinates = input.split.map(&:to_i)
      @robot_coordinates = validate_robot_coordinates(x: non_validated_coordinates[1], y: non_validated_coordinates[0])
    end
  end

  def validate_size_input(non_validated_size)
    raise ArgumentError.new("Invalid size: Size must be an odd number between 3 and 100") unless non_validated_size.between?(3, 100) && non_validated_size.odd?
    non_validated_size
  end

  def validate_row_input(non_validated_rows)
    raise ArgumentError.new("Invalid row: Size of rows do not match the input size") unless non_validated_rows.all?{|row| row.length == size}
    raise ArgumentError.new("Invalid row: Number of rows does not match the input size") unless non_validated_rows.length == size
    non_validated_rows
  end

  def validate_robot_coordinates(x:, y:)
    raise ArgumentError.new("Invalid location: One or more coordinates for robot are missing") unless x && y
    raise ArgumentError.new("Invalid location: Robot coordinates must fit with the size of the grid using matrix convention") unless x < size && y < size
    {x: x, y: y}
  end
end

class PrincessSaver
  attr_reader :input_reader, :matrix
  def initialize
    @input_reader = InputReader.new
  end

  def make_matrix
    @matrix ||= Matrix.new(input_reader.size, input_reader.matrix_rows, input_reader.robot_coordinates)
  end

  def directions_to_princess
    matrix.robot.directions_to_princess(matrix.princess.coordinates)
  end

  def next_move_to_save_princess
    directions_to_princess
    matrix.robot.next_move
  end
end

# # Challenge 1
saver = PrincessSaver.new
saver.input_reader.get_matrix_size
saver.input_reader.get_matrix_rows
saver.make_matrix

puts saver.directions_to_princess

# Challenge 2
saver = PrincessSaver.new
saver.input_reader.get_matrix_size
saver.input_reader.get_robot_coordinates
saver.input_reader.get_matrix_rows
saver.make_matrix

puts saver.next_move_to_save_princess