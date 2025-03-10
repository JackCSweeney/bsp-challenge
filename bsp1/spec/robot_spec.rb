require_relative './spec_helper'
require_relative '../lib/robot.rb'

RSpec.describe Robot do
  describe 'Initialize' do
    it 'exists' do
      robot = Robot.new([2,2])

      expect(robot).to be_a(Robot)
    end

    it 'has coords attribute' do
      robot = Robot.new([2,2])

      expect(robot.coords).to eq([2,2])
    end
  end
end