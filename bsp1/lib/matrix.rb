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
    for i in (0...@size) do
      for j in (0...@size) do
        if @grid[i][j] == 'p'
          return [j, i]
        end
      end
    end
  end

  def get_robot_coords
    center = @size / 2
    [center, center]
  end
end