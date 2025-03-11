require_relative './spec_helper'
require_relative '../lib/princess_saver.rb'

RSpec.describe PrincessSaver do
  describe 'Initialize' do
    it 'exists' do
      princess_saver = PrincessSaver.new

      expect(princess_saver).to be_a(PrincessSaver)
    end
  end

  before(:each) do
    @saver = PrincessSaver.new
    @input_1 = "3\np--\n-m-\n---"
    @input_2 = "7\n-------\n-------\n-------\n---m---\n-------\np------\n-------"
    @input_3 = "9\n---------\n---------\n---------\n---------\n----m----\n---------\n---------\n-------p-\n---------"
    @input_4 = "5\n---p-\n-----\n--m--\n-----\n-----"
  end

  describe '#instance methods' do
    describe '#save_princess' do
      describe 'different board sizes and all 4 directions' do
        it 'can find the right directions for a 3x3 board' do
          allow($stdin).to receive(:gets).and_return(@input_1)
          expected = "LEFT\nUP\n"

          expect {@saver.save_princess}.to output(expected).to_stdout
        end

        it 'can find the right directions for a 7x7 board' do
          allow($stdin).to receive(:gets).and_return(@input_2)
          expected = "LEFT\nLEFT\nLEFT\nDOWN\nDOWN\n"

          expect {@saver.save_princess}.to output(expected).to_stdout
        end

        it 'can find the right directions for a 9x9 board' do
          allow($stdin).to receive(:gets).and_return(@input_3)
          expected = "RIGHT\nRIGHT\nRIGHT\nDOWN\nDOWN\nDOWN\n"

          expect {@saver.save_princess}.to output(expected).to_stdout
        end

        it 'can find the right directions for a 5x5 board' do
          allow($stdin).to receive(:gets).and_return(@input_4)
          expected = "RIGHT\nUP\nUP\n"

          expect {@saver.save_princess}.to output(expected).to_stdout
        end
      end
    end
  end
end