require_relative 'robot.rb'
require_relative 'princess.rb'

class Matrix
  attr_reader :size, :grid, :robot, :princess

  def initialize(size, rows, robot_coords=[])
    @size = size
    @grid = rows.map {|row| row.chars}
    @robot_coords = robot_coords
    @robot = Robot.new(set_coords_for_robot)
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

  def set_coords_for_robot
    if @robot_coords.empty?
      [(@size / 2), (@size / 2)]
    else
      @robot_coords
    end
  end
end