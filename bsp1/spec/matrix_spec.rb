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
    describe '.get_princess_coords' do
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
  end
end