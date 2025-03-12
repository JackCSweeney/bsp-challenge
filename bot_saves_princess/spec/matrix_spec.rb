require_relative './spec_helper'
require_relative '../lib/matrix.rb'

RSpec.describe Matrix do
  describe 'Initialize' do
    it 'exists' do
      matrix = Matrix.new(3, ['---','-m-','--p'])

      expect(matrix).to be_a(Matrix)
    end

    it 'has a readable size attribute' do
      matrix = Matrix.new(3, ['---','-m-','--p'])

      expect(matrix.size).to eq(3)
    end

    it 'has a readable grid attribute that maps the rows it is initialized with' do
      matrix = Matrix.new(3, ['---','-m-','--p'])

      expect(matrix.grid).to eq([['-','-','-'], ['-','m','-'], ['-','-','p']])
    end

    it 'has a readable robot attribute that is an instance of a robot with the correct coords' do
      matrix = Matrix.new(3, ['---','-m-','--p'])

      expect(matrix.robot).to be_a(Robot)
      expect(matrix.robot.coordinates).to eq({x:1, y:1})
    end

    it 'has a readable princess attribute that is an instance of a princess with the correct coords' do
      matrix = Matrix.new(3, ['p--','-m-','---'])

      expect(matrix.princess).to be_a(Princess)
      expect(matrix.princess.coordinates).to eq({x:0, y:0})
    end
  end

  describe '#instance methods' do
    describe '#coordinates_for_princess' do
      describe 'Happy Path' do
        it 'will return the coordinates of the princess within the grid' do
          matrix = Matrix.new(3, ['---','-m-','--p'])

          expect(matrix.coordinates_for_princess).to eq({x:2, y:2})
        end

        it 'can return the coordinates with the princess in a different location' do
          matrix = Matrix.new(3, ['---','-m-','p--'])

          expect(matrix.coordinates_for_princess).to eq({x:0, y:2})
        end

        it 'can return the coordinates with a different size grid' do
          matrix = Matrix.new(5, ['----p','-----','--m--','-----','-----'])

          expect(matrix.coordinates_for_princess).to eq({x:4, y:0})
        end

        it 'can return the coordinates for the princess in a location other than the 4 corners' do
          matrix = Matrix.new(5, ['-----','-p---','--m--','-----','-----'])

          expect(matrix.coordinates_for_princess).to eq({x:1, y:1})
        end
      end
    end

    describe '#coordinates_for_robot' do
      describe 'Happy Path' do
        it 'will return the location of the robot from the grid as the center when robot_coords attribute is empty' do
          matrix = Matrix.new(3, ['p--','-m-','---'])

          expect(matrix.coordinates_for_robot).to eq({x:1, y:1})
        end

        it 'will return the location of the robot from a different size grid as the center when robot_coords attribute is empty' do
          matrix = Matrix.new(5, ['p----','-----','--m--','-----','-----'])

          expect(matrix.coordinates_for_robot).to eq({x:2, y:2})
        end

        it 'will return the location of the robot from the grid as the given coordinates when present' do
          matrix = Matrix.new(5, ['-----','m----','-----','-----','----p'], {x:0, y:1})

          expect(matrix.coordinates_for_robot).to eq({x:0, y:1})
        end
      end
    end
  end
end