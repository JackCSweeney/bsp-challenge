require_relative 'positionable'
require_relative 'direction_manager'

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