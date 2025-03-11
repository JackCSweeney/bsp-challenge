require 'robot.rb'
require 'princess.rb'

class Matrix
  attr_reader :size, :grid, :robot, :princess

  def initialize(size, rows)
    @size = size
    @grid = rows.map {|row| row.chars}
    @robot = Robot.new(get_robot_coords)
    @princess = Princess.new(get_princess_coords)
  end

  def get_princess_coords
    if @grid[0][0] == 'p'
      [0,0]
    elsif @grid[0][@size - 1] == 'p'
      [@size - 1, 0]
    elsif @grid[@size - 1][0] == 'p'
      [0,@size - 1]
    else
      [@size - 1, @size - 1]
    end
  end

  def get_robot_coords
    center = @size / 2
    [center, center]
  end
end