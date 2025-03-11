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
    @input_1 = "p--\n-m-\n---"
    @input_2 = "-------\n-------\n-------\n---m---\n-------\np------\n-------"
    @input_3 = "---------\n---------\n---------\n---------\n----m----\n---------\n---------\n-------p-\n---------"
    @input_4 = "---p-\n-----\n--m--\n-----\n-----"
  end

  describe '#instance methods' do
    describe '#save_princess' do
      describe 'different board sizes and all 4 directions' do
        it 'can find the right directions for a 3x3 board' do
          allow($stdin).to receive(:gets).and_return("3")
          @saver.input_reader.get_matrix_size
          allow($stdin).to receive(:gets).and_return(@input_1)
          @saver.input_reader.get_matrix_rows
          expected = "LEFT\nUP\n"

          expect {@saver.save_princess}.to output(expected).to_stdout
        end

        it 'can find the right directions for a 7x7 board' do
          allow($stdin).to receive(:gets).and_return("7")
          @saver.input_reader.get_matrix_size
          allow($stdin).to receive(:gets).and_return(@input_2)
          @saver.input_reader.get_matrix_rows
          expected = "LEFT\nLEFT\nLEFT\nDOWN\nDOWN\n"

          expect {@saver.save_princess}.to output(expected).to_stdout
        end

        it 'can find the right directions for a 9x9 board' do
          allow($stdin).to receive(:gets).and_return("9")
          @saver.input_reader.get_matrix_size
          allow($stdin).to receive(:gets).and_return(@input_3)
          @saver.input_reader.get_matrix_rows
          expected = "RIGHT\nRIGHT\nRIGHT\nDOWN\nDOWN\nDOWN\n"

          expect {@saver.save_princess}.to output(expected).to_stdout
        end

        it 'can find the right directions for a 5x5 board' do
          allow($stdin).to receive(:gets).and_return("5")
          @saver.input_reader.get_matrix_size
          allow($stdin).to receive(:gets).and_return(@input_4)
          @saver.input_reader.get_matrix_rows
          expected = "RIGHT\nUP\nUP\n"

          expect {@saver.save_princess}.to output(expected).to_stdout
        end
      end
    end
  end
end