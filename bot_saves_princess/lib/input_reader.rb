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
    {x:, y:}
  end
end