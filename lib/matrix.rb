require_relative 'robot'
require_relative 'princess'

class Matrix
  attr_reader :size, :grid, :robot, :princess

  def initialize(size, rows, robot_coordinates={})
    @size = size
    @grid = rows.map(&:chars)
    @robot = Robot.new(**coordinates_for_robot(robot_coordinates))
    @princess = Princess.new(**coordinates_for_princess)
  end

  def coordinates_for_princess
    grid.flatten.each_with_index do |cell, index|
      return {x: (index % @size), y: (index / @size)} if cell == 'p'
    end
  end

  def coordinates_for_robot(provided_coordinates)
    return provided_coordinates if provided_coordinates[:x] && provided_coordinates[:y]
    {x: (size / 2), y: (size / 2)}
  end
end