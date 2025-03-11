require 'input_reader.rb'
require 'matrix.rb'

class PrincessSaver
  attr_reader :input_reader
  def initialize
    @input_reader = InputReader.new
    @matrix = nil
  end

  def make_matrix
    @matrix = Matrix.new(@input_reader.size, @input_reader.matrix_rows)
  end

  def save_princess
    make_matrix
    puts @matrix.robot.directions_to_princess(@matrix.princess.coords)
  end
end