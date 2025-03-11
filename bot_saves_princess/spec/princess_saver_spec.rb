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
    describe '#save_princess' do
      describe 'different board sizes and all 4 directions' do
        it 'can find the right directions for a 3x3 board' do
          # additional empty string added to account for not being able to force stubs to be used a second time during check for robot coordinates and provide sequential input values at the same time to :gets
          allow($stdin).to receive(:gets).and_return("3","","p--","-m-","---")
          expected = "LEFT\nUP\n"

          expect {@saver.save_princess}.to output(expected).to_stdout
        end

        it 'can find the right directions for a 7x7 board' do
          allow($stdin).to receive(:gets).and_return("7","","-------","-------","-------","---m---","-------","-------","p------")
          expected = "LEFT\nLEFT\nLEFT\nDOWN\nDOWN\nDOWN\n"

          expect {@saver.save_princess}.to output(expected).to_stdout
        end

        it 'can find the right directions for a 9x9 board' do
          allow($stdin).to receive(:gets).and_return("9","","---------","---------","---------","---------","----m----","---------","---------","---------","--------p")
          expected = "RIGHT\nRIGHT\nRIGHT\nRIGHT\nDOWN\nDOWN\nDOWN\nDOWN\n"

          expect {@saver.save_princess}.to output(expected).to_stdout
        end

        it 'can find the right directions for a 5x5 board' do
          allow($stdin).to receive(:gets).and_return("5","","----p","-----","--m--","-----","-----")
          expected = "RIGHT\nRIGHT\nUP\nUP\n"

          expect {@saver.save_princess}.to output(expected).to_stdout
        end
      end
    end

    describe '#next_move' do
      it 'will output only the next move the robot makes towards the princess on a 3x3 board' do
        allow($stdin).to receive(:gets).and_return("3","1 1","p--","-m-","---")
        
        expect {@saver.next_move}.to output("LEFT\n").to_stdout
      end

      it 'will output only the next move the robot makes towards the princess on a 5x5 board' do
        allow($stdin).to receive(:gets).and_return("5","2 2","----p","-----","--m--","-----","-----")
        
        expect {@saver.next_move}.to output("RIGHT\n").to_stdout
      end

      it 'will output only the next move the robot makes towards the princess on a 3x3 board with princess and robot in different position' do
        allow($stdin).to receive(:gets).and_return("3","2 1","-p-","---","-m-")
        
        expect {@saver.next_move}.to output("UP\n").to_stdout
      end

      it 'will output only the next move the robot makes towards the princess on a 5x5 board with princess and robot in different position' do
        allow($stdin).to receive(:gets).and_return("5","3 2","-----","-----","-----","--n--","--p--")

        expect {@saver.next_move}.to output("DOWN\n").to_stdout
      end
    end
  end
end