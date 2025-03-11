require_relative 'input_reader.rb'
require_relative 'matrix.rb'

class PrincessSaver
  attr_reader :input_reader
  def initialize
    @input_reader = InputReader.new
    @matrix = nil
  end

  def get_input
    @input_reader.get_matrix_size
    @input_reader.get_robot_coordinates
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