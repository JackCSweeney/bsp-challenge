require_relative './spec_helper'
require_relative '../lib/robot.rb'

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
          robot = matrix.robot

          expect(robot.directions_to_princess).to eq(["UP"])
        end

        it 'can return the correct steps with the princess in a different location' do
          matrix = Matrix.new(3, ['--p','-m-','---'])

          expect(robot.directions_to_princess).to eq(["UP", "RIGHT"])
        end

        it 'can return the correct steps with a different sized grid' do
          matrix = Matrix.new(5, ['-----','-----','--m--','-----','----p'])

          expect(robot.directions_to_princess).to eq(["DOWN", "DOWN", "RIGHT", "RIGHT"])
        end

        it 'can return the correct steps with a different sized grid going left' do
          matrix = Matrix.new(5, ['-----','-----','--m--','-----','p----'])

          expect(robot.directions_to_princess).to eq(["DOWN", "DOWN", "LEFT", "LEFT"])
        end
      end
    end
  end
end