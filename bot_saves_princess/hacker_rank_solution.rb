class InputReader
  attr_reader :size, :matrix_rows

  def initialize
    @size = 0
    @matrix_rows = []
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
    rows = []
    @size.times do
      rows << $stdin.gets.chomp
    end
    @matrix_rows = validate_row_input(rows)
  end

  def validate_row_input(rows)
    raise ArgumentError.new("Invalid row: Rows do not match the input size") if rows.any?{|row| row.length != @size}
    raise ArgumentError.new("Invalid row: Number of rows does not match the input size") if rows.length != @size
    rows
  end
end

class Robot
  attr_reader :coords, :directions

  def initialize(coords)
    @coords = coords
    @directions = []
  end

  def directions_to_princess(princess_coords)
    x_directions(@coords[0] - princess_coords[0])
    y_directions(@coords[1] - princess_coords[1])
    @directions
  end

  def x_directions(x_val)
    if x_val.positive?
      x_val.times do
        @directions << "LEFT"
      end
    else
      x_val.abs.times do
        @directions << "RIGHT"
      end
    end
  end

  def y_directions(y_val)
    if y_val.positive?
      y_val.times do
        @directions << "UP"
      end
    else
      y_val.abs.times do
        @directions << "DOWN"
      end
    end
  end
end

class Princess
  attr_reader :coords

  def initialize(coords)
    @coords = coords
  end
end

class Matrix
  attr_reader :size, :grid, :robot, :princess

  def initialize(size, rows)
    @size = size
    @grid = rows.map {|row| row.chars}
    @robot = Robot.new(get_robot_coords)
    @princess = Princess.new(get_princess_coords)
  end

  def get_princess_coords
    if @grid[0][0] == 'p'
      [0,0]
    elsif @grid[0][@size - 1] == 'p'
      [@size - 1, 0]
    elsif @grid[@size - 1][0] == 'p'
      [0,@size - 1]
    else
      [@size - 1, @size - 1]
    end
  end

  def get_robot_coords
    center = @size / 2
    [center, center]
  end
end

class PrincessSaver
  attr_reader :input_reader
  def initialize
    @input_reader = InputReader.new
    @matrix = nil
  end

  def get_input
    @input_reader.get_matrix_size
    @input_reader.get_matrix_rows
  end

  def make_matrix
    @matrix = Matrix.new(@input_reader.size, @input_reader.matrix_rows)
  end

  def save_princess
    get_input
    make_matrix
    puts @matrix.robot.directions_to_princess(@matrix.princess.coords)
  end
end

saver = PrincessSaver.new
saver.save_princess