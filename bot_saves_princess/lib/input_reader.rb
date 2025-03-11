class InputReader
  attr_reader :size, :matrix_rows, :robot_coordinates

  def initialize
    @size = 0
    @matrix_rows = []
    @robot_coordinates = []
  end

  def get_matrix_size
    size = $stdin.gets.to_i
    @size = validate_size_input(size)
  end

  def validate_size_input(size)
    raise ArgumentError.new("Invalid size: Size must be an odd number between 3 and 100") if size < 3 || size > 100 || size.even?
    size
  end

  def get_matrix_rows
    rows = $stdin.gets.split[1..-1]
    @matrix_rows = validate_row_input(rows)
  end

  def validate_row_input(rows)
    raise ArgumentError.new("Invalid row: Size of rows do not match the input size") if rows.any?{|row| row.length != @size}
    raise ArgumentError.new("Invalid row: Number of rows does not match the input size") if rows.length != @size
    rows
  end

  def get_robot_coordinates
    if /[[:digit:]]/.match($stdin.gets[0])
      @robot_coordinates = $stdin.gets.split.map(&:to_i).reverse
    end
  end
end