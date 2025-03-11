require_relative './spec_helper'
require_relative '../lib/input_reader.rb'

RSpec.describe InputReader do
  describe 'Initialize' do
    it 'exists' do
      reader = InputReader.new

      expect(reader).to be_a(InputReader)
    end

    it 'is initialized with size and matrix_rows attributes as 0 and an empty array' do
      reader = InputReader.new

      expect(reader.size).to eq(0)
      expect(reader.matrix_rows).to eq([])
    end
  end

  before(:each) do
    @reader = InputReader.new
  end

  describe '#instance methods' do
    describe '.get_matrix_size' do
      describe 'Happy Path' do
        it 'gets the size of the matrix from the stdin' do
          allow($stdin).to receive(:gets).and_return('5')

          @reader.get_matrix_size

          expect(@reader.size).to eq(5)
        end

        it 'works with a different size' do
          allow($stdin).to receive(:gets).and_return('3')

          @reader.get_matrix_size

          expect(@reader.size).to eq(3)
        end
      end

      describe 'Sad Path' do
        it 'raises an error message if the input value is not odd' do
          allow($stdin).to receive(:gets).and_return('4')

          expect {@reader.get_matrix_size}.to raise_error(ArgumentError)
          expect {@reader.get_matrix_size}.to raise_error("Invalid size: Size must be an odd number between 3 and 100")
        end

        it 'raises an error message if the input value is below 3' do
          allow($stdin).to receive(:gets).and_return('1')

          expect {@reader.get_matrix_size}.to raise_error(ArgumentError)
          expect {@reader.get_matrix_size}.to raise_error("Invalid size: Size must be an odd number between 3 and 100")
        end

        it 'raises an error message if the input value is greater than 100' do
          allow($stdin).to receive(:gets).and_return('101')

          expect {@reader.get_matrix_size}.to raise_error(ArgumentError)
          expect {@reader.get_matrix_size}.to raise_error("Invalid size: Size must be an odd number between 3 and 100")
        end
      end
    end

    describe '.get_matrix_rows' do
      describe 'Happy Path' do
        it 'can add input rows to its attribute of matrix rows' do
          allow($stdin).to receive(:gets).and_return("3\n---\n---\n---")
          @reader.get_matrix_size
          @reader.get_matrix_rows

          expect(@reader.matrix_rows).to eq(['---', '---', '---'])
        end

        it 'can add different number of input rows to its attribute of matrix rows' do
          allow($stdin).to receive(:gets).and_return("5\n-----\n-----\n-----\n-----\n-----")
          @reader.get_matrix_size
          @reader.get_matrix_rows

          expect(@reader.matrix_rows).to eq(['-----', '-----', '-----', '-----', '-----'])
        end
      end

      describe 'Sad Path' do
        it 'raises an error message if the number of rows do not match the input size' do
          allow($stdin).to receive(:gets).and_return("5\n-----\n-----\n-----\n-----")
          @reader.get_matrix_size

          expect {@reader.get_matrix_rows}.to raise_error(ArgumentError)
          expect {@reader.get_matrix_rows}.to raise_error("Invalid row: Number of rows does not match the input size")
        end

        it 'raises an error message if the length of the rows does not match the matrix size' do
          allow($stdin).to receive(:gets).and_return("3\n---\n---\n--")
          @reader.get_matrix_size

          expect {@reader.get_matrix_rows}.to raise_error(ArgumentError)
          expect {@reader.get_matrix_rows}.to raise_error("Invalid row: Size of rows do not match the input size")
        end
      end
    end

    describe 'get_robot_coordinates' do
      describe 'Happy Path' do
        it 'can get the coordinates of the bot from the second input given' do
          allow($stdin).to receive(:gets).and_return("5")
          @reader.get_matrix_size
          allow($stdin).to receive(:gets).and_return("2 3")
          @reader.get_robot_coordinates

          expect(@reader.robot_coordinates).to eq([3,2])
        end

        it 'can get the coordinates of the bot from a different second input' do
          allow($stdin).to receive(:gets).and_return("25")
          @reader.get_matrix_size
          allow($stdin).to receive(:gets).and_return("11 0")
          @reader.get_robot_coordinates

          expect(@reader.robot_coordinates).to eq([0,11])
        end

        it 'will only set the coordinates if the second input received are integers' do
          allow($stdin).to receive(:gets).and_return("3")
          @reader.get_matrix_size
          allow($stdin).to receive(:gets).and_return("---\n---\n---\n")
          @reader.get_robot_coordinates

          expect(@reader.robot_coordinates).to eq([])
        end
      end

      describe 'Sad Path' do
        it 'raises the correct error if coordinates given are not in range of the given size' do
          allow($stdin).to receive(:gets).and_return("3")
          @reader.get_matrix_size
          allow($stdin).to receive(:gets).and_return("3 0")

          expect {@reader.get_robot_coordinates}.to raise_error(ArgumentError)
          expect {@reader.get_robot_coordinates}.to raise_error("Invalid location: Robot coordinates must fit with the size of the grid using matrix convention")
        end

        it 'raises the correct error if only given 1 coordinate' do
          allow($stdin).to receive(:gets).and_return("3")
          @reader.get_matrix_size
          allow($stdin).to receive(:gets).and_return("3 0")

          expect {@reader.get_robot_coordinates}.to raise_error(ArgumentError)
          expect {@reader.get_robot_coordinates}.to raise_error("Invalid location: Robot coordinates must fit with the size of the grid using matrix convention")
        end
      end
    end
  end
end