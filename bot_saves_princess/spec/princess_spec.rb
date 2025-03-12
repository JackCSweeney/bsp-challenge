require_relative './spec_helper'
require_relative '../lib/princess.rb'

RSpec.describe Princess do
  describe 'Initialize' do
    it 'exists' do
      princess = Princess.new(x:0, y:0)

      expect(princess).to be_a(Princess)
    end

    it 'has a coords attribute' do
      princess = Princess.new(x:0, y:0)

      expect(princess.coordinates).to eq({x:0, y:0})
    end
  end
end