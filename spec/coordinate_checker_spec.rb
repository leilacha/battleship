# frozen_string_literal: true

require 'spec_helper'
require_relative '../coordinate_checker'

describe CoordinateChecker do
  let(:coordinate) { 'A1' }
  let(:subject) { CoordinateChecker.new(coordinate: coordinate, board_rows: 2, board_columns: 2) }
  describe '#check' do
    context 'when coordinate is valid' do
      it 'returns true' do
        expect(subject.check).to eq(true)
      end
    end
    context 'when coordinate is not valid' do
      let(:error) { "is not a valid coordinate. Please try again\n" }
      context 'when coordinate is more than 2 characters' do
        let(:coordinate) { 'blaaa' }
        it 'puts error message and returns false' do
          expect { subject.check }.to output("blaaa #{error}").to_stdout
          expect(subject.check).to eq(false)
        end
      end
      context 'when coordinate is 2 numbers characters' do
        let(:coordinate) { '11' }
        it 'puts error message and returns false' do
          expect { subject.check }.to output("11 #{error}").to_stdout
          expect(subject.check).to eq(false)
        end
      end
      context 'when coordinate is 2 string characters' do
        let(:coordinate) { 'ZZ' }
        it 'puts error message and returns false' do
          expect { subject.check }.to output("ZZ #{error}").to_stdout
          expect(subject.check).to eq(false)
        end
      end
      context 'when coordinate of x_axis is out of range' do
        let(:coordinate) { 'Z1' }
        it 'puts error message and returns false' do
          expect { subject.check }.to output("Z1 #{error}").to_stdout
          expect(subject.check).to eq(false)
        end
      end
      context 'when coordinate of y_axis is out of range' do
        let(:coordinate) { 'A8' }
        it 'puts error message and returns false' do
          expect { subject.check }.to output("A8 #{error}").to_stdout
          expect(subject.check).to eq(false)
        end
      end
    end
  end
end
