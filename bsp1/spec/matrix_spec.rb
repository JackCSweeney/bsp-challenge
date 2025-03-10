require_relative './spec_helper'
require_relative '../lib/matrix.rb'

RSpec.describe Matrix do
  describe 'initialize' do
    it 'exists' do
      matrix = Matrix.new(3, ['---','---','---'])

      expect(matrix).to be_a(Matrix)
    end
  end
end