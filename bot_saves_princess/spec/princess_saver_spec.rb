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
  end

  describe '#instance methods' do
    describe '#directions_to_princess' do
      describe 'different board sizes and all 4 directions' do
        it 'can find the right directions for a 3x3 board' do
          allow($stdin).to receive(:gets).and_return("3")
          @saver.input_reader.get_matrix_size
          allow($stdin).to receive(:gets).and_return("p--","-m-","---")
          @saver.input_reader.get_matrix_rows

          @saver.make_matrix

          expect(@saver.directions_to_princess).to eq(["LEFT", "UP"])
        end

        it 'can find the right directions for a 7x7 board' do
          allow($stdin).to receive(:gets).and_return("7")
          @saver.input_reader.get_matrix_size
          allow($stdin).to receive(:gets).and_return("-------","-------","-------","---m---","-------","-------","p------")
          @saver.input_reader.get_matrix_rows

          @saver.make_matrix

          expect(@saver.directions_to_princess).to eq(["LEFT", "LEFT", "LEFT", "DOWN", "DOWN", "DOWN"])
        end

        it 'can find the right directions for a 9x9 board' do
          allow($stdin).to receive(:gets).and_return("9")
          @saver.input_reader.get_matrix_size
          allow($stdin).to receive(:gets).and_return("---------","---------","---------","---------","----m----","---------","---------","---------","--------p")
          @saver.input_reader.get_matrix_rows

          @saver.make_matrix

          expect(@saver.directions_to_princess).to eq(["RIGHT", "RIGHT", "RIGHT", "RIGHT", "DOWN", "DOWN", "DOWN", "DOWN"])
        end

        it 'can find the right directions for a 5x5 board' do
          allow($stdin).to receive(:gets).and_return("5")
          @saver.input_reader.get_matrix_size
          allow($stdin).to receive(:gets).and_return("----p","-----","--m--","-----","-----")
          @saver.input_reader.get_matrix_rows
          
          @saver.make_matrix

          expect(@saver.directions_to_princess).to eq(["RIGHT", "RIGHT", "UP", "UP"])
        end
      end
    end

    describe '#next_move_to_save_princess' do
      it 'will output only the next move the robot makes towards the princess on a 3x3 board' do
        allow($stdin).to receive(:gets).and_return("3","1 1","p--","-m-","---")
        @saver.input_reader.get_matrix_size
        @saver.input_reader.get_robot_coordinates
        @saver.input_reader.get_matrix_rows
        @saver.make_matrix
        
        expect(@saver.next_move_to_save_princess).to eq("LEFT")
      end

      it 'will output only the next move the robot makes towards the princess on a 5x5 board' do
        allow($stdin).to receive(:gets).and_return("5","2 2","----p","-----","--m--","-----","-----")
        @saver.input_reader.get_matrix_size
        @saver.input_reader.get_robot_coordinates
        @saver.input_reader.get_matrix_rows
        @saver.make_matrix
        
        expect(@saver.next_move_to_save_princess).to eq("RIGHT")
      end

      it 'will output only the next move the robot makes towards the princess on a 3x3 board with princess and robot in different position' do
        allow($stdin).to receive(:gets).and_return("3","2 1","-p-","---","-m-")
        @saver.input_reader.get_matrix_size
        @saver.input_reader.get_robot_coordinates
        @saver.input_reader.get_matrix_rows
        @saver.make_matrix
        
        expect(@saver.next_move_to_save_princess).to eq("UP")
      end

      it 'will output only the next move the robot makes towards the princess on a 5x5 board with princess and robot in different position' do
        allow($stdin).to receive(:gets).and_return("5","3 2","-----","-----","-----","--n--","--p--")
        @saver.input_reader.get_matrix_size
        @saver.input_reader.get_robot_coordinates
        @saver.input_reader.get_matrix_rows
        @saver.make_matrix

        expect(@saver.next_move_to_save_princess).to eq("DOWN")
      end
    end
  end
end