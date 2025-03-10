require_relative './spec_helper'
require_relative '../lib/matrix.rb'

RSpec.describe Matrix do
  describe 'initialize' do
    it 'exists' do
      matrix = Matrix.new(3, ['---','---','---'])

      expect(matrix).to be_a(Matrix)
    end

    it 'has a size attribute' do
      matrix = Matrix.new(3, ['---','---','---'])

      expect(matrix.size).to eq(3)
    end

    it 'has a grid attribute that maps the rows it is initialized with' do
      matrix = Matrix.new(3, ['---','---','---'])

      expect(matrix.grid).to eq([['-','-','-'], ['-','-','-'], ['-','-','-']])
    end
  end

  describe '#instance methods' do
    describe '#get_princess_coords' do
      describe 'Happy Path' do
        it 'will return the coordinates of the princess within the grid' do
          matrix = Matrix.new(3, ['-p-','---','---'])

          expect(matrix.get_princess_coords).to eq([1,0])
        end

        it 'can return the coordinates with the princess in a different location' do
          matrix = Matrix.new(3, ['---','---','p--'])

          expect(matrix.get_princess_coords).to eq([0,2])
        end

        it 'can return the coordinates with a different size grid' do
          matrix = Matrix.new(5, ['-----','-----','p----','-----','-----'])

          expect(matrix.get_princess_coords).to eq([0,2])
        end
      end
    end

    describe '#get_robot_coords' do
      describe 'Happy Path' do
        it 'will return the location of the robot from the grid' do
          matrix = Matrix.new(3, ['-p-','-m-','---'])

          expect(matrix.get_robot_coords).to eq([1,1])
        end

        it 'will return the location of the robot from a different size grid' do
          matrix = Matrix.new(5, ['-----','-----','p-m--','-----','-----'])

          expect(matrix.get_robot_coords).to eq([2,2])
        end
      end
    end

    describe '#directions_to_princess' do
      describe 'Happy Path' do
        it 'returns the correct steps needed to save the princess' do
          matrix = Matrix.new(3, ['-p-','-m-','---'])
          robot = Robot.new(matrix.get_robot_coords)

          expect(robot.directions_to_princess).to eq(["UP"])
        end

        it 'can return the correct steps with the princess in a different location' do
          matrix = Matrix.new(3, ['--p','-m-','---'])
          robot = Robot.new(matrix.get_robot_coords)

          expect(robot.directions_to_princess).to eq(["UP", "RIGHT"])
        end

        it 'can return the correct steps with a different sized grid' do
          matrix = Matrix.new(5, ['-----','-----','--m--','-----','----p'])

          robot = Robot.new(matrix.get_robot_coords)

          expect(robot.directions_to_princess).to eq(["DOWN", "DOWN", "RIGHT", "RIGHT"])
        end

        it 'can return the correct steps with a different sized grid going left' do
          matrix = Matrix.new(5, ['-----','-----','--m--','-----','p----'])

          robot = Robot.new(matrix.get_robot_coords)

          expect(robot.directions_to_princess).to eq(["DOWN", "DOWN", "LEFT", "LEFT"])
        end
      end
    end
  end
end