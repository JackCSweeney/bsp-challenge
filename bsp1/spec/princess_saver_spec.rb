require_relative './spec_helper'
require_relative '../lib/princess_saver.rb'

RSpec.describe PrincessSaver do
  describe '.Initialize' do
    it 'exists' do
      princess_saver = PrincessSaver.new

      expect(princess_saver).to be_a(PrincessSaver)
    end

    it 'is initialized with an empty array for directions attribute' do
      princess_saver = PrincessSaver.new

      expect(princess_saver.directions).to eq([])
    end
  end

  before(:each) do
    @saver = PrincessSaver.new
    @input_1 = [['p','-','-'],
                ['-','m','-'],
                ['-','-','-']]
    @input_2 = [['-','-','-','-','-','-','-'],
                ['-','-','-','-','-','-','-'],
                ['-','-','-','-','-','-','-'],
                ['-','-','-','m','-','-','-'],
                ['-','-','-','-','-','-','-'],
                ['p','-','-','-','-','-','-'],
                ['-','-','-','-','-','-','-']]
    @input_3 = [['-','-','-','-','-','-','-','-','-'],
                ['-','-','-','-','-','-','-','-','-'],
                ['-','-','-','-','-','-','-','-','-'],
                ['-','-','-','-','-','-','-','-','-'],
                ['-','-','-','-','m','-','-','-','-'],
                ['-','-','-','-','-','-','-','-','-'],
                ['-','-','-','-','-','-','-','-','-'],
                ['-','-','-','-','-','-','-','p','-'],
                ['-','-','-','-','-','-','-','-','-']]
    @input_4 = [['-','-','-','p','-'],
                ['-','-','-','-','-'],
                ['-','-','m','-','-'],
                ['-','-','-','-','-'],
                ['-','-','-','-','-']]
  end

  describe '#find_directions(grid)' do
    describe 'different board sizes and all 4 directions' do
      it 'can find the right directions for a 3x3 board' do
        directions = @saver.find_directions(@input_1)

        expect(directions).to be_a(Array)
        expect(directions.length).to eq(2)
        expect(directions).to eq(["LEFT", "UP"])
      end

      it 'can find the right directions for a 7x7 board' do
        directions = @saver.find_directions(@input_2)

        expect(directions).to be_a(Array)
        expect(directions.length).to eq(5)
        expect(directions).to eq(["LEFT", "LEFT", "LEFT", "DOWN", "DOWN"])
      end

      it 'can find the right directions for a 9x9 board' do
        directions = @saver.find_directions(@input_3)

        expect(directions).to be_a(Array)
        expect(directions.length).to eq(9)
        expect(directions).to eq(["RIGHT", "RIGHT", "RIGHT", "DOWN", "DOWN", "DOWN"])
      end

      it 'can find the right directions for a 5x5 board' do
        directions = @saver.find_directions(@input_4)

        expect(directions).to be_a(Array)
        expect(directions.length).to eq(6)
        expect(directions).to eq(["RIGHT", "UP", "UP"])
      end
    end
  end
end