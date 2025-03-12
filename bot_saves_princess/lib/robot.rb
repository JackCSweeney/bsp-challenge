require_relative 'princess.rb'
class Robot < Princess
  attr_reader :directions

  def initialize(x:, y:)
    super
    @directions = []
  end

  def directions_to_princess(princess_coordinates)
    x_axis_directions(@coordinates[:x] - princess_coordinates[:x])
    y_axis_directions(@coordinates[:y] - princess_coordinates[:y])
    @directions
  end

  def x_axis_directions(x_axis_distance)
    return x_axis_distance.times {@directions << "LEFT"} if x_axis_distance.positive?
    x_axis_distance.abs.times {@directions << "RIGHT"} 
  end

  def y_axis_directions(y_axis_distance)
    return y_axis_distance.times {@directions << "UP"} if y_axis_distance.positive?
    y_axis_distance.abs.times {@directions << "DOWN"}  
  end

  def next_move
    next_direction = @directions.shift
    return move_robot_on_x_axis(next_direction) if next_direction == "LEFT" || next_direction == "RIGHT"
    move_robot_on_y_axis(next_direction) if next_direction == "UP" || next_direction == "DOWN"
  end

  def move_robot_on_x_axis(next_direction)
    next_direction == "RIGHT" ? @coordinates[:x] += 1 : @coordinates[:x] -= 1
    next_direction
  end

  def move_robot_on_y_axis(next_direction)
    next_direction == "UP" ? @coordinates[:y] += 1 : @coordinates[:y] -= 1
    next_direction
  end
end