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
    {x:, y:}
  end
end