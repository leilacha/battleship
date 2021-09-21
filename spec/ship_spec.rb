# frozen_string_literal: true

require 'spec_helper'
require_relative '../ship'

describe Ship do
  let(:ship) { Ship.new(size: 3) }
  describe '#initialize' do
    it 'initializes attributes' do
      expect(ship.coordinates).to eq([])
    end
  end

  describe 'sank?' do
    context 'ship does not have coordinates' do
      it 'returns true' do
        expect(ship.sank?).to eq(true)
      end
    end

    context 'ship has coordinates' do
      before do
        ship.coordinates = ['A1']
      end
      it 'returns false' do
        expect(ship.sank?).to eq(false)
      end
    end
  end

  describe 'aligned?' do
    context 'given coordinates are aligned' do
      context 'vertically aligned' do
        before do
          ship.coordinates = %w[A1 A2 A3 A4]
        end
        it 'returns true' do
          expect(ship.aligned?).to eq(true)
        end
      end
      context 'horizontallylly aligned' do
        before do
          ship.coordinates = %w[A1 B1 C1 D1]
        end
        it 'returns true' do
          expect(ship.aligned?).to eq(true)
        end
      end
    end

    context 'given coordinates are not aligned' do
      context 'vertically aligned' do
        before do
          ship.coordinates = %w[A1 A3 A4]
        end
        it 'returns false' do
          expect(ship.aligned?).to eq(false)
        end
      end
      context 'horizontallylly aligned' do
        before do
          ship.coordinates = %w[A1 B1 D1]
        end
        it 'returns false' do
          expect(ship.aligned?).to eq(false)
        end
      end
    end
  end
end
