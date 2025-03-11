require_relative './spec_helper'
require_relative '../lib/matrix.rb'

RSpec.describe Matrix do
  describe 'Initialize' do
    it 'exists' do
      matrix = Matrix.new(3, ['---','---','---'])

      expect(matrix).to be_a(Matrix)
    end

    it 'has a readable size attribute' do
      matrix = Matrix.new(3, ['---','---','---'])

      expect(matrix.size).to eq(3)
    end

    it 'has a readable grid attribute that maps the rows it is initialized with' do
      matrix = Matrix.new(3, ['---','---','---'])

      expect(matrix.grid).to eq([['-','-','-'], ['-','-','-'], ['-','-','-']])
    end

    it 'has a readable robot attribute that is an instance of a robot with the correct coords' do
      matrix = Matrix.new(3, ['---','-m-','---'])

      expect(matrix.robot).to be_a(Robot)
      expect(matrix.robot.coords).to eq([1,1])
    end

    it 'has a readable princess attribute that is an instance of a princess with the correct coords' do
      matrix = Matrix.new(3, ['p--','-m-','---'])

      expect(matrix.princess).to be_a(Princess)
      expect(matrix.princess.coords).to eq([0,0])
    end
  end

  describe '#instance methods' do
    describe '#get_princess_coords' do
      describe 'Happy Path' do
        it 'will return the coordinates of the princess within the grid' do
          matrix = Matrix.new(3, ['---','---','--p'])

          expect(matrix.get_princess_coords).to eq([2,2])
        end

        it 'can return the coordinates with the princess in a different location' do
          matrix = Matrix.new(3, ['---','---','p--'])

          expect(matrix.get_princess_coords).to eq([0,2])
        end

        it 'can return the coordinates with a different size grid' do
          matrix = Matrix.new(5, ['----p','-----','-----','-----','-----'])

          expect(matrix.get_princess_coords).to eq([4,0])
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
  end
end