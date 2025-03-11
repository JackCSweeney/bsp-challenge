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
    grid.flatten.each_with_index do |cell, index|
      return [index % @size, (index / @size)] if cell == 'p'
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