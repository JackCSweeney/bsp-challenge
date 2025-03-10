require 'robot.rb'

class Matrix
  attr_reader :size, :grid, :robot

  def initialize(size, rows)
    @size = size
    @grid = rows.map {|row| row.chars}
    @princess_coords = get_princess_coords
    @robot_coords = get_robot_coords
    @robot = Robot.new(@robot_coords)
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