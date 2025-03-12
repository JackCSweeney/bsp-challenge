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
      describe 'Happy Path' do
        it 'returns the correct steps needed to save the princess' do
          princess = Princess.new(x:0, y:0)
          robot = Robot.new(x:1, y:1)

          expect(robot.directions_to_princess(princess.coordinates)).to eq(["LEFT", "UP"])
        end

        it 'can return the correct steps with the princess in a different location' do
          princess = Princess.new(x:2, y:0)
          robot = Robot.new(x:1, y:1)

          expect(robot.directions_to_princess(princess.coordinates)).to eq(["RIGHT", "UP"])
        end

        it 'can return the correct steps with a different sized grid' do
          princess = Princess.new(x:4, y:4)
          robot = Robot.new(x:2, y:2)

          expect(robot.directions_to_princess(princess.coordinates)).to eq(["RIGHT", "RIGHT", "DOWN", "DOWN"])
        end

        it 'can return the correct steps with a different sized grid going left' do
          princess = Princess.new(x:0, y:4)
          robot = Robot.new(x:2, y:2)

          expect(robot.directions_to_princess(princess.coordinates)).to eq(["LEFT", "LEFT", "DOWN", "DOWN"])
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

    describe '#next_move' do
      it 'returns the next move it should make to get closer to the princess' do
        p_coords = [4,4]
        robot = Robot.new([2,2])
        robot.directions_to_princess(p_coords)

        expect(robot.next_move).to eq("RIGHT")
      end

      it 'updates the directions attribute to remove the move it just made' do
        p_coords = [4,4]
        robot = Robot.new([2,2])
        robot.directions_to_princess(p_coords)

        expect(robot.directions).to eq(["RIGHT", "RIGHT", "DOWN", "DOWN"])

        robot.next_move

        expect(robot.directions).to eq(["RIGHT", "DOWN", "DOWN"])
      end

      it 'updates the robots coordinates based on its move' do
        p_coords = [4,4]
        robot = Robot.new([2,2])
        robot.directions_to_princess(p_coords)
        robot.next_move

        expect(robot.coords).to eq([3,2])

        robot.next_move

        expect(robot.coords).to eq([4,2])
      end

      it 'works with a different grid and location' do
        p_coords = [2,0]
        robot = Robot.new([2,2])
        robot.directions_to_princess(p_coords)

        expect(robot.directions).to eq(["UP", "UP"])
        expect(robot.next_move).to eq("UP")
        expect(robot.directions).to eq(["UP"])
      end
    end

    describe '#change_coordinates(direction_moved)' do
      it 'updates the coordinates based on the direction moved' do
        robot = Robot.new([2,2])
        robot.change_coordinates("UP")

        expect(robot.coords).to eq([2,3])

        robot.change_coordinates("LEFT")

        expect(robot.coords).to eq([1,3])
      end
    end
  end
end