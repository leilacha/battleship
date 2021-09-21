# frozen_string_literal: true

require 'spec_helper'
require_relative '../case'

describe Case do
  let(:my_case) { Case.new(x_axis: 0, y_axis: 0) }
  describe '#initialize' do
    it 'initializes attributes' do
      expect(my_case.pawn).to eq(nil)
      expect(my_case.hidden).to eq(true)
    end
  end

  describe '#empty?' do
    context 'when case does not have a pawn' do
      it 'returns true' do
        expect(my_case.empty?).to eq(true)
      end
    end
    context 'when case has a pawn' do
      before do
        my_case.pawn = '@'
      end
      it 'returns false' do
        expect(my_case.empty?).to eq(false)
      end
    end
  end

  describe '#displayed_pawn' do
    context 'when there is no pawn' do
      context 'and case is hidden' do
        it 'returns o' do
          expect(my_case.displayed_pawn(player_pawn: '*')).to eq('o')
        end
      end
      context 'and case is not hidden' do
        before do
          my_case.hidden = false
        end
        it 'returns o' do
          expect(my_case.displayed_pawn(player_pawn: '*')).to eq('x')
        end
      end
    end
    context 'when there is a pawn' do
      context 'it is the player pawn' do
        before do
          my_case.pawn = '*'
        end
        it 'returns pawn' do
          expect(my_case.displayed_pawn(player_pawn: '*')).to eq('*')
        end
      end
      context 'it is not the player pawn' do
        before do
          my_case.pawn = '@'
        end
        context 'and case is hidden' do
          it 'returns o' do
            expect(my_case.displayed_pawn(player_pawn: '*')).to eq('o')
          end
        end
        context 'and case is not hidden' do
          before do
            my_case.hidden = false
          end
          it 'returns o' do
            expect(my_case.displayed_pawn(player_pawn: '*')).to eq('@')
          end
        end
      end
    end
  end

  describe '#to_coordinates' do
    it 'translates case position to coordinates' do
      expect(my_case.to_coordinates).to eq('A1')
    end
  end
end
