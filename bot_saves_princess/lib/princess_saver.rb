require_relative 'input_reader'
require_relative 'matrix'

class PrincessSaver
  attr_reader :input_reader, :matrix
  def initialize
    @input_reader = InputReader.new
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