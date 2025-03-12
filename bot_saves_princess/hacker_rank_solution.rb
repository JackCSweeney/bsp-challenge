class Princess
  attr_reader :coordinates

  def initialize(x:, y:)
    @coordinates = {x: x, y: y}
  end
end

class Robot < Princess
  attr_reader :directions

  def initialize(x:, y:)
    super
    @directions = []
  end

  def directions_to_princess(princess_coordinates)
    x_axis_directions(@coordinates[:x] - princess_coordinates[:x])
    y_axis_directions(@coordinates[:y] - princess_coordinates[:y])
    @directions
  end

  def x_axis_directions(x_axis_distance)
    return x_axis_distance.times {@directions << "LEFT"} if x_axis_distance.positive?
    x_axis_distance.abs.times {@directions << "RIGHT"} 
  end

  def y_axis_directions(y_axis_distance)
    return y_axis_distance.times {@directions << "UP"} if y_axis_distance.positive?
    y_axis_distance.abs.times {@directions << "DOWN"}  
  end

  def next_move
    next_direction = @directions.shift
    return move_robot_on_x_axis(next_direction) if next_direction == "LEFT" || next_direction == "RIGHT"
    move_robot_on_y_axis(next_direction) if next_direction == "UP" || next_direction == "DOWN"
  end

  def move_robot_on_x_axis(next_direction)
    next_direction == "RIGHT" ? @coordinates[:x] += 1 : @coordinates[:x] -= 1
    next_direction
  end

  def move_robot_on_y_axis(next_direction)
    next_direction == "UP" ? @coordinates[:y] += 1 : @coordinates[:y] -= 1
    next_direction
  end
end

class Matrix
  attr_reader :size, :grid, :robot, :princess

  def initialize(size, rows, robot_coordinates={})
    @size = size
    @grid = rows.map {|row| row.chars}
    @robot_coordinates = robot_coordinates
    @robot = Robot.new(x: coordinates_for_robot[:x], y: coordinates_for_robot[:y])
    @princess = Princess.new(x: coordinates_for_princess[:x], y: coordinates_for_princess[:y])
  end

  def coordinates_for_princess
    grid.flatten.each_with_index do |cell, index|
      return {x: (index % @size), y: (index / @size)} if cell == 'p'
    end
  end

  def coordinates_for_robot
    @robot_coordinates = {x: (size / 2), y: (size / 2)} if !@robot_coordinates[:x] || !@robot_coordinates[:y]
    @robot_coordinates
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

  def validate_size_input(size)
    raise ArgumentError.new("Invalid size: Size must be an odd number between 3 and 100") if size < 3 || size > 100 || size.even?
    size
  end

  def get_matrix_rows
    rows = []
    @size.times {rows << $stdin.gets.chomp}
    @matrix_rows = validate_row_input(rows)
  end

  def validate_row_input(rows)
    raise ArgumentError.new("Invalid row: Size of rows do not match the input size") if rows.any?{|row| row.length != @size}
    raise ArgumentError.new("Invalid row: Number of rows does not match the input size") if rows.length != @size
    rows
  end

  def get_robot_coordinates
    input = $stdin.gets
    if /[[:digit:]]/.match(input)
      coordinates = input.split.map(&:to_i)
      @robot_coordinates = validate_robot_coordinates(x: coordinates[1], y: coordinates[0])
    end
  end

  def validate_robot_coordinates(x:, y:)
    raise ArgumentError.new("Invalid location: One or more coordinates for robot are missing") if !x || !y 
    raise ArgumentError.new("Invalid location: Robot coordinates must fit with the size of the grid using matrix convention") if x >= size || y >= size
    {x: x, y: y}
  end
end

class PrincessSaver
  attr_reader :input_reader, :matrix
  def initialize
    @input_reader = InputReader.new
    @matrix = nil
  end

  def make_matrix
    @matrix = Matrix.new(input_reader.size, input_reader.matrix_rows, input_reader.robot_coordinates)
  end

  def directions_to_princess
    matrix.robot.directions_to_princess(matrix.princess.coordinates)
  end

  def next_move_to_save_princess
    directions_to_princess
    matrix.robot.next_move
  end
end


saver = PrincessSaver.new
saver.input_reader.get_matrix_size
saver.input_reader.get_robot_coordinates
saver.input_reader.get_matrix_rows
saver.make_matrix

puts saver.next_move_to_save_princess