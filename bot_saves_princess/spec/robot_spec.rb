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

    describe '#directions_to_princess' do
      it 'will return the correct steps with the princess in the top left corner of a 3x3 grid' do
        princess = Princess.new(x:0, y:0)
        robot = Robot.new(x:1, y:1)

        expect(robot.directions_to_princess(princess.coordinates)).to eq(["LEFT", "UP"])
      end

      it 'will return the correct steps with the princess in the top right corner of a 3x3 grid' do
        princess = Princess.new(x:2, y:0)
        robot = Robot.new(x:1, y:1)

        expect(robot.directions_to_princess(princess.coordinates)).to eq(["RIGHT", "UP"])
      end

      it 'will return the correct steps in a 5x5 grid and the princess in the bottom right corner' do
        princess = Princess.new(x:4, y:4)
        robot = Robot.new(x:2, y:2)

        expect(robot.directions_to_princess(princess.coordinates)).to eq(["RIGHT", "RIGHT", "DOWN", "DOWN"])
      end

      it 'will return the correct steps in a 5x5 grid and the princess in the bottom left corner' do
        princess = Princess.new(x:0, y:4)
        robot = Robot.new(x:2, y:2)

        expect(robot.directions_to_princess(princess.coordinates)).to eq(["LEFT", "LEFT", "DOWN", "DOWN"])
      end

      it 'will return the correct steps in a 5x5 grid when the princess is not in a corner and bot is in center' do
        princess = Princess.new(x:0, y:3)
        robot = Robot.new(x:2, y:2)

        expect(robot.directions_to_princess(princess.coordinates)).to eq(["LEFT", "LEFT", "DOWN"])
      end

      it 'will return the correct steps in a 5x5 grid when the princess is not in a corner and bot is not in the center' do
        princess = Princess.new(x:0, y:3)
        robot = Robot.new(x:3, y:0)

        expect(robot.directions_to_princess(princess.coordinates)).to eq(["LEFT", "LEFT", "LEFT", "DOWN", "DOWN", "DOWN"])
      end

      it 'will return empty directions when the bot and princess are in the same location in the grid' do
        princess = Princess.new(x:3, y:3)
        robot = Robot.new(x:3, y:3)

        expect(robot.directions_to_princess(princess.coordinates)).to eq([])
      end
    end

    describe '#x_axis_directions(x_axis_distance)' do
      it 'adds the directions needed on the x-axis to the directions attribute of robot for moving right' do
        robot = Robot.new(x:2, y:2)
        robot.x_axis_directions(-2)
        
        expect(robot.directions).to eq(["RIGHT", "RIGHT"])
      end

      it 'adds directions to the right for a further distance' do
        robot = Robot.new(x:2, y:2)
        robot.x_axis_directions(-5)
        
        expect(robot.directions).to eq(["RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT"])
      end

      it 'adds the directions needed on the x-axis to the directions attribute of robot for moving left' do
        robot = Robot.new(x:2, y:2)
        robot.x_axis_directions(2)
        
        expect(robot.directions).to eq(["LEFT", "LEFT"])
      end

      it 'adds directions to the left for a further distance' do
        robot = Robot.new(x:2, y:2)
        robot.x_axis_directions(5)
        
        expect(robot.directions).to eq(["LEFT", "LEFT", "LEFT", "LEFT", "LEFT"])
      end
    end

    describe '#y_axis_directions(y_axis_distance)' do
      it 'adds the directions needed on the y-axis to the directions attribute of robot' do
        robot = Robot.new(x:2, y:2)
        robot.y_axis_directions(2)
        
        expect(robot.directions).to eq(["UP", "UP"])
      end

      it 'works in the other direction' do
        robot = Robot.new(x:2, y:2)
        robot.y_axis_directions(-2)
        
        expect(robot.directions).to eq(["DOWN", "DOWN"])
      end
    end

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