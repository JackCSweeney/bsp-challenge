require_relative './spec_helper'
require_relative '../lib/princess.rb'

RSpec.describe Princess do
  describe 'Initialize' do
    it 'exists' do
      princess = Princess.new([0,0])

      expect(princess).to be_a(Princess)
    end

    it 'has a coords attribute' do
      princess = Princess.new([0,0])

      expect(princess.coords).to eq([0,0])
    end
  end
end