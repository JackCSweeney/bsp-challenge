class DirectionManager
  attr_reader :directions
  
  def initialize(start, target)
    @start = start
    @target = target
    @directions = []
  end

  def calculate_directions
    x_axis_directions
    y_axis_directions
    @directions
  end

  def x_axis_directions
    distance = @start[:x] - @target[:x]
    move = distance.positive? ? 'LEFT' : 'RIGHT'
    distance.abs.times { @directions << move }
  end

  def y_axis_directions
    distance = @start[:y] - @target[:y]
    move = distance.positive? ? 'UP' : 'DOWN'
    distance.abs.times { @directions << move }
  end
end