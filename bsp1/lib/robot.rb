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