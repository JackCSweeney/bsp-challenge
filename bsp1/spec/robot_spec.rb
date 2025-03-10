require_relative './spec_helper'
require_relative '../lib/robot.rb'
require_relative '../lib/matrix.rb'

RSpec.describe Robot do
  describe 'Initialize' do
    it 'exists' do
      robot = Robot.new([2,2])

      expect(robot).to be_a(Robot)
    end

    it 'has coords attribute' do
      robot = Robot.new([2,2])

      expect(robot.coords).to eq([2,2])
    end

    describe '#directions_to_princess' do
      describe 'Happy Path' do
        it 'returns the correct steps needed to save the princess' do
          matrix = Matrix.new(3, ['-p-','-m-','---'])
          p_coords = matrix.princess_coords
          robot = matrix.robot

          expect(robot.directions_to_princess(p_coords)).to eq(["UP"])
        end

        it 'can return the correct steps with the princess in a different location' do
          matrix = Matrix.new(3, ['--p','-m-','---'])
          p_coords = matrix.princess_coords
          robot = matrix.robot

          expect(robot.directions_to_princess(p_coords)).to eq(["RIGHT", "UP"])
        end

        it 'can return the correct steps with a different sized grid' do
          matrix = Matrix.new(5, ['-----','-----','--m--','-----','----p'])
          p_coords = matrix.princess_coords
          robot = matrix.robot

          expect(robot.directions_to_princess(p_coords)).to eq(["RIGHT", "RIGHT", "DOWN", "DOWN"])
        end

        it 'can return the correct steps with a different sized grid going left' do
          matrix = Matrix.new(5, ['-----','-----','--m--','-----','p----'])
          p_coords = matrix.princess_coords
          robot = matrix.robot

          expect(robot.directions_to_princess(p_coords)).to eq(["LEFT", "LEFT", "DOWN", "DOWN"])
        end
      end
    end

    describe '#x_directions(x_val)' do
      it 'adds the directions needed on the x-axis to the directions attribute of robot' do
        robot = Robot.new([2,2])
        robot.x_directions(-2)
        
        expect(robot.directions).to eq(["RIGHT", "RIGHT"])
      end

      it 'works in the other direction' do
        robot = Robot.new([2,2])
        robot.x_directions(2)
        
        expect(robot.directions).to eq(["LEFT", "LEFT"])
      end
    end

    describe '#y_directions(y_val)' do
      it 'adds the directions needed on the y-axis to the directions attribute of robot' do
        robot = Robot.new([2,2])
        robot.y_directions(2)
        
        expect(robot.directions).to eq(["UP", "UP"])
      end

      it 'works in the other direction' do
        robot = Robot.new([2,2])
        robot.y_directions(-2)
        
        expect(robot.directions).to eq(["DOWN", "DOWN"])
      end
    end
  end
end