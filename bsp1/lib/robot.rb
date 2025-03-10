class Robot
  attr_reader :coords

  def initialize(coords)
    @coords = coords
    @directions = []
  end

  def directions_to_princess(princess_coords)
    x_val = @coords[0] - princess_coords[0]
    y_val = @coords[1] - princess_coords[1]

    if x_val.positive?
      x_val.times do
        @directions << "LEFT"
      end
    else
      x_val.abs.times do
        @directions << "RIGHT"
      end
    end

    if y_val.positive?
      y_val.times do
        @directions << "UP"
      end
    else
      y_val.abs.times do
        @directions << "DOWN"
      end
    end

    @directions
  end
end