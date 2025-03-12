require_relative 'princess.rb'
class Robot < Princess
  attr_reader :directions

  def initialize(x:, y:)
    super
    @directions = []
  end

  def directions_to_princess(princess_coordinates)
    x_axis_moves(@coordinates[:x] - princess_coordinates[:x])
    y_axis_moves(@coordinates[:y] - princess_coordinates[:y])
    @directions
  end

  def x_axis_moves(x_axis_distance)
    return x_axis_distance.times {@directions << "LEFT"} if x_axis_distance.positive?
    x_axis_distance.abs.times {@directions << "RIGHT"} 
  end

  def y_axis_moves(y_axis_distance)
    return y_axis_distance.times {@directions << "UP"} if y_axis_distance.positive?
    y_axis_distance.abs.times {@directions << "DOWN"}  
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