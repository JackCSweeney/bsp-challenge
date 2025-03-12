require_relative './spec_helper.rb'

RSpec.describe DirectionManager do
  describe 'Initialize' do
    it 'exists' do
      manager = DirectionManager.new({x:1, y:1}, {x:2, y:2})

      expect(manager).to be_a(DirectionManager)
    end
  end

  describe '#Instance Methods' do
    describe '#calculate_directions' do
      it 'will return the correct steps with the princess in the top left corner of a 3x3 grid' do
        princess = Princess.new(x:0, y:0)
        robot = Robot.new(x:1, y:1)
        manager = DirectionManager.new(robot.coordinates, princess.coordinates)

        expect(manager.calculate_directions).to eq(["LEFT", "UP"])
      end

      it 'will return the correct steps with the princess in the top right corner of a 3x3 grid' do
        princess = Princess.new(x:2, y:0)
        robot = Robot.new(x:1, y:1)
        manager = DirectionManager.new(robot.coordinates, princess.coordinates)

        expect(manager.calculate_directions).to eq(["RIGHT", "UP"])
      end

      it 'will return the correct steps in a 5x5 grid and the princess in the bottom right corner' do
        princess = Princess.new(x:4, y:4)
        robot = Robot.new(x:2, y:2)
        manager = DirectionManager.new(robot.coordinates, princess.coordinates)

        expect(manager.calculate_directions).to eq(["RIGHT", "RIGHT", "DOWN", "DOWN"])
      end

      it 'will return the correct steps in a 5x5 grid and the princess in the bottom left corner' do
        princess = Princess.new(x:0, y:4)
        robot = Robot.new(x:2, y:2)
        manager = DirectionManager.new(robot.coordinates, princess.coordinates)

        expect(manager.calculate_directions).to eq(["LEFT", "LEFT", "DOWN", "DOWN"])
      end

      it 'will return the correct steps in a 5x5 grid when the princess is not in a corner and bot is in center' do
        princess = Princess.new(x:0, y:3)
        robot = Robot.new(x:2, y:2)
        manager = DirectionManager.new(robot.coordinates, princess.coordinates)

        expect(manager.calculate_directions).to eq(["LEFT", "LEFT", "DOWN"])
      end

      it 'will return the correct steps in a 5x5 grid when the princess is not in a corner and bot is not in the center' do
        princess = Princess.new(x:0, y:3)
        robot = Robot.new(x:3, y:0)
        manager = DirectionManager.new(robot.coordinates, princess.coordinates)

        expect(manager.calculate_directions).to eq(["LEFT", "LEFT", "LEFT", "DOWN", "DOWN", "DOWN"])
      end

      it 'will return empty directions when the bot and princess are in the same location in the grid' do
        princess = Princess.new(x:3, y:3)
        robot = Robot.new(x:3, y:3)
        manager = DirectionManager.new(robot.coordinates, princess.coordinates)

        expect(manager.calculate_directions).to eq([])
      end
    end

    describe 'x_axis_directions' do
      it 'adds the directions needed on the x-axis to the directions attribute of robot for moving right' do
        princess = Princess.new(x:4, y:3)
        robot = Robot.new(x:2, y:2)
        manager = DirectionManager.new(robot.coordinates, princess.coordinates)
        manager.x_axis_directions
        
        expect(manager.directions).to eq(["RIGHT", "RIGHT"])
      end

      it 'adds directions to the right for a further distance' do
        princess = Princess.new(x:5, y:3)
        robot = Robot.new(x:0, y:2)
        manager = DirectionManager.new(robot.coordinates, princess.coordinates)
        manager.x_axis_directions
        
        expect(manager.directions).to eq(["RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT"])
      end

      it 'adds the directions needed on the x-axis to the directions attribute of robot for moving left' do
        princess = Princess.new(x:0, y:3)
        robot = Robot.new(x:2, y:2)
        manager = DirectionManager.new(robot.coordinates, princess.coordinates)
        manager.x_axis_directions
        
        expect(manager.directions).to eq(["LEFT", "LEFT"])
      end

      it 'adds directions to the left for a further distance' do
        princess = Princess.new(x:0, y:3)
        robot = Robot.new(x:5, y:2)
        manager = DirectionManager.new(robot.coordinates, princess.coordinates)
        manager.x_axis_directions
        
        expect(manager.directions).to eq(["LEFT", "LEFT", "LEFT", "LEFT", "LEFT"])
      end
    end

    describe 'y_axis_directions' do
      it 'adds the directions needed on the y-axis to the directions attribute of robot for moving up' do
        princess = Princess.new(x:5, y:2)
        robot = Robot.new(x:0, y:4)
        manager = DirectionManager.new(robot.coordinates, princess.coordinates)
        manager.y_axis_directions
        
        expect(manager.directions).to eq(["UP", "UP"])
      end

      it 'adds directions up for a further distance' do
        princess = Princess.new(x:5, y:2)
        robot = Robot.new(x:0, y:7)
        manager = DirectionManager.new(robot.coordinates, princess.coordinates)
        manager.y_axis_directions
        
        expect(manager.directions).to eq(["UP", "UP", "UP", "UP", "UP"])
      end

      it 'adds the directions needed on the y-axis to the directions attribute of robot for moving down' do
        princess = Princess.new(x:2, y:2)
        robot = Robot.new(x:0, y:0)
        manager = DirectionManager.new(robot.coordinates, princess.coordinates)
        manager.y_axis_directions
        
        expect(manager.directions).to eq(["DOWN", "DOWN"])
      end

      it 'adds directions down for a further distance' do
        princess = Princess.new(x:2, y:5)
        robot = Robot.new(x:0, y:0)
        manager = DirectionManager.new(robot.coordinates, princess.coordinates)
        manager.y_axis_directions
        
        expect(manager.directions).to eq(["DOWN", "DOWN", "DOWN", "DOWN", "DOWN"])
      end
    end
  end
end
