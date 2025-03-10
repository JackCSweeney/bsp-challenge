require_relative './spec_helper'
require_relative '../lib/input_reader.rb'

RSpec.describe InputReader do
  describe 'Initialize' do
    it 'exists' do
      reader = InputReader.new

      expect(reader).to be_a(InputReader)
    end
  end

  describe '.class methods' do
    describe '.get_matrix_size' do
      describe 'Happy Path' do
        it 'gets the size of the matrix from the stdin' do
          allow($stdin).to receive(:gets).and_return('5')

          expect(InputReader.get_matrix_size).to eq(5)
        end

        it 'works with a different size' do
          allow($stdin).to receive(:gets).and_return('3')

          expect(InputReader.get_matrix_size).to eq(3)
        end
      end

      describe 'Sad Path' do
        it 'raises an error message if the input value is not odd' do
          allow($stdin).to receive(:gets).and_return('4')

          expect {InputReader.get_matrix_size}.to raise_error(ArgumentError)
        end

        it 'raises an error message if the input value is below 3' do
          allow($stdin).to receive(:gets).and_return('1')

          expect {InputReader.get_matrix_size}.to raise_error(ArgumentError)
        end

        it 'raises an error message if the input value is greater than 100' do
          allow($stdin).to receive(:gets).and_return('101')

          expect {InputReader.get_matrix_size}.to raise_error(ArgumentError)
        end
      end
    end
  end
end