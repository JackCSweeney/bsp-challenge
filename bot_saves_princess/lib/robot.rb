require_relative 'princess.rb'
class Robot < Princess
  attr_reader :directions

  def initialize(coords)
    super
    @directions = []
  end

  def directions_to_princess(princess_coords)
    x_directions(@coords[0] - princess_coords[0])
    y_directions(@coords[1] - princess_coords[1])
    @directions
  end

  def x_directions(x_val)
    return x_val.times {@directions << "LEFT"} if x_val.positive?
    x_val.abs.times {@directions << "RIGHT"} 
  end

  def y_directions(y_val)
    return y_val.times {@directions << "UP"} if y_val.positive?
    y_val.abs.times {@directions << "DOWN"}  
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