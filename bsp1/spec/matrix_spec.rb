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

    it 'has a grid attribute that maps the rows it is initialize with' do
      matrix = Matrix.new(3, ['---','---','---'])

      expect(matrix.grid).to eq([['-','-','-'], ['-','-','-'], ['-','-','-']])
    end
  end
end