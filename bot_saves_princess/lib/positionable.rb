module Positionable
  attr_reader :coordinates
  
  def initialize(x:, y:)
    @coordinates = {x:, y:}
  end

  def move_on_x_axis(amount)
    @coordinates[:x] += amount
  end

  def move_on_y_axis(amount)
    @coordinates[:y] += amount
  end
end