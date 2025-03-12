require_relative './spec_helper'
require_relative '../lib/robot.rb'
require_relative '../lib/matrix.rb'

RSpec.describe Robot do
  describe 'Initialize' do
    it 'exists' do
      robot = Robot.new(x:2, y:2)

      expect(robot).to be_a(Robot)
    end

    it 'has coords attribute' do
      robot = Robot.new(x:2, y:2)

      expect(robot.coordinates).to eq({x:2, y:2})
    end

    describe '#Instance Methods' do
      describe '#next_move' do
        it 'returns the next move it should make to get closer to the princess' do
          princess = Princess.new(x:4, y:4)
          robot = Robot.new(x:2, y:2)
          robot.directions_to_princess(princess.coordinates)

          expect(robot.next_move).to eq("RIGHT")
        end

        it 'updates the directions attribute to remove the move it just made' do
          princess = Princess.new(x:4, y:4)
          robot = Robot.new(x:2, y:2)
          robot.directions_to_princess(princess.coordinates)

          expect(robot.directions).to eq(["RIGHT", "RIGHT", "DOWN", "DOWN"])

          robot.next_move

          expect(robot.directions).to eq(["RIGHT", "DOWN", "DOWN"])
        end

        it 'updates the robots coordinates based on its move' do
          princess = Princess.new(x:4, y:4)
          robot = Robot.new(x:2, y:2)
          robot.directions_to_princess(princess.coordinates)
          robot.next_move

          expect(robot.coordinates).to eq({x:3, y:2})

          robot.next_move

          expect(robot.coordinates).to eq({x:4, y:2})
        end

        it 'works with a different grid and location' do
          princess = Princess.new(x:2, y:0)
          robot = Robot.new(x:2, y:2)
          robot.directions_to_princess(princess.coordinates)

          expect(robot.directions).to eq(["UP", "UP"])
          expect(robot.next_move).to eq("UP")
          expect(robot.directions).to eq(["UP"])
        end
      end

      describe '#move_robot_on_y_axis(next_direction)' do
        it 'updates the coordinates based on the direction moved' do
          robot = Robot.new(x:2, y:2)
          robot.move_robot_on_y_axis("UP")

          expect(robot.coordinates).to eq(x:2, y:3)

          robot.move_robot_on_y_axis("DOWN")

          expect(robot.coordinates).to eq(x:2, y:2)
        end
      end

      describe '#move_robot_on_x_axis(next_direction)' do
        it 'updates the coordinates based on the direction moved' do
          robot = Robot.new(x:2, y:2)
          robot.move_robot_on_x_axis("LEFT")

          expect(robot.coordinates).to eq({x:1, y:2})

          robot.move_robot_on_x_axis("RIGHT")

          expect(robot.coordinates).to eq({x:2, y:2})
        end
      end
    end
  end
end