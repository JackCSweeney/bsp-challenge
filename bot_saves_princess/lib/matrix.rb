require_relative 'robot.rb'
require_relative 'princess.rb'

class Matrix
  attr_reader :size, :grid, :robot, :princess

  def initialize(size, rows, robot_coordinates={})
    @size = size
    @grid = rows.map {|row| row.chars}
    @robot_coordinates = robot_coordinates
    @robot = Robot.new(x: coordinates_for_robot[:x], y: coordinates_for_robot[:y])
    @princess = Princess.new(x: coordinates_for_princess[:x], y: coordinates_for_princess[:y])
  end

  def coordinates_for_princess
    grid.flatten.each_with_index do |cell, index|
      return {x: (index % @size), y: (index / @size)} if cell == 'p'
    end
  end

  def coordinates_for_robot
    @robot_coordinates = {x: (size / 2), y: (size / 2)} if !@robot_coordinates[:x] || !@robot_coordinates[:y]
    @robot_coordinates
  end
end