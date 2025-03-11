class InputReader
  attr_reader :size, :matrix_rows, :robot_coordinates

  def initialize
    @size = 0
    @matrix_rows = []
    @robot_coordinates = []
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
      coords = input.split.map(&:to_i).reverse
      @robot_coordinates = validate_robot_coordinates(coords)
    end
  end

  def validate_robot_coordinates(coords)
    raise ArgumentError.new("Invalid location: Robot coordinates must fit with the size of the grid using matrix convention") if coords.any?{|num| num >= @size}
    coords
  end
end

class Matrix
  attr_reader :size, :grid, :robot, :princess

  def initialize(size, rows, robot_coords=[])
    @size = size
    @grid = rows.map {|row| row.chars}
    @robot_coords = robot_coords
    @robot = Robot.new(set_coords_for_robot)
    @princess = Princess.new(get_princess_coords)
  end

  def get_princess_coords
    grid.flatten.each_with_index do |cell, index|
      return [index % @size, (index / @size)] if cell == 'p'
    end
  end

  def set_coords_for_robot
    if @robot_coords.empty?
      [(@size / 2), (@size / 2)]
    else
      @robot_coords
    end
  end
end

class PrincessSaver
  attr_reader :input_reader, :matrix
  def initialize
    @input_reader = InputReader.new
    @matrix = nil
  end

  def get_input
    input_reader.get_matrix_size
    input_reader.get_robot_coordinates
    input_reader.get_matrix_rows
  end

  def make_matrix
    @matrix = Matrix.new(input_reader.size, input_reader.matrix_rows, input_reader.robot_coordinates)
  end

  def save_princess
    get_input
    make_matrix
    puts matrix.robot.directions_to_princess(matrix.princess.coords)
  end

  def next_move
    get_input
    make_matrix
    matrix.robot.directions_to_princess(matrix.princess.coords)
    puts matrix.robot.next_move
  end
end

class Princess
  attr_reader :coords

  def initialize(coords)
    @coords = coords
  end
end

class Robot < Princess
  attr_reader :directions

  def initialize(coords)
    super
    @directions = []
  end

  def directions_to_princess(princess_coords)
    x_directions(@coords[0] - princess_coords[0])
    y_directions(@coords[1] - princess_coords[1])
    @directions
  end

  def x_directions(x_val)
    return x_val.times {@directions << "LEFT"} if x_val.positive?
    x_val.abs.times {@directions << "RIGHT"} 
  end

  def y_directions(y_val)
    return y_val.times {@directions << "UP"} if y_val.positive?
    y_val.abs.times {@directions << "DOWN"}  
  end

  def next_move
    change_coordinates(@directions.first)
    @directions.shift
  end

  def change_coordinates(direction_moved)
    case direction_moved
    when "LEFT"
      @coords[0] -= 1
    when "RIGHT"
      @coords[0] += 1
    when "UP"
      @coords[-1] += 1
    when "DOWN"
      @coords[-1] -= 1
    end
  end
end

PrincessSaver.new.next_move