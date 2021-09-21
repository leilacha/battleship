# frozen_string_literal: true

require 'spec_helper'
require_relative '../board'

describe Board do
  let(:board) { Board.new(columns: 5, rows: 7) }
  describe '#initialize' do
    it 'initializes attributes' do
      expect(board.cases.count).to eq(5 * 7)
    end
  end

  describe '#print' do
    let(:expected_print) do
      "########################\n  A B C D E\n1 o o o o o\n2 o o o o o\n"\
      "3 o o o o o\n4 o o o o o\n5 o o o o o\n6 o o o o o\n7 o o o o o\n"\
      "########################\n"
    end
    it 'prints board to screen' do
      expect { board.print(player_pawn: '&') }.to output(expected_print).to_stdout
    end
  end

  describe '#check_placement' do
    let(:case1) { Case.new(x_axis: 0, y_axis: 0) }
    let(:case2) { Case.new(x_axis: 0, y_axis: 1) }
    let(:case3) { Case.new(x_axis: 3, y_axis: 3) }
    before do
      board.cases = [case1, case2, case3]
    end
    context 'coordinates are empty' do
      it 'returns false' do
        expect(board.check_placement(coordinates: [])).to eq(false)
      end
    end
    context 'coordinates are all empty' do
      it 'returns cases' do
        expect(board.check_placement(coordinates: %w[A1 A2])).to eq([case1, case2])
      end
    end

    context 'coordinates are not all empty' do
      before do
        case1.pawn = '@'
      end
      it 'returns false' do
        expect(board.check_placement(coordinates: %w[A1 A2])).to eq(false)
      end
    end
  end

  describe '#validate_placement' do
    let(:case1) { Case.new(x_axis: 0, y_axis: 0) }
    let(:case2) { Case.new(x_axis: 0, y_axis: 1) }
    let(:case3) { Case.new(x_axis: 3, y_axis: 3) }
    before do
      board.cases = [case1, case2, case3]
    end
    it 'place the pawn in the right cases' do
      expect do
        board.validate_placement(coordinates: %w[A1 A2], pawn: '*')
      end.to change { case1.pawn }.from(nil).to('*')
                                  .and change { case2.pawn }.from(nil).to('*')
                                                            .and not_change { case3.pawn }
    end
  end

  describe '#unhide_cases' do
    let(:case1) { Case.new(x_axis: 0, y_axis: 0) }
    let(:case2) { Case.new(x_axis: 0, y_axis: 1) }
    let(:case3) { Case.new(x_axis: 3, y_axis: 3) }
    before do
      board.cases = [case1, case2, case3]
    end
    it 'place the pawn in the right cases' do
      expect do
        board.unhide_cases(coordinates: %w[A1 A2])
      end.to change { case1.hidden }.from(true).to(false)
                                    .and change { case2.hidden }.from(true).to(false)
                                                                .and not_change { case3.hidden }
    end
  end
end
