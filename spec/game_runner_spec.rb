# frozen_string_literal: true

require 'spec_helper'
require_relative '../player'
require_relative '../ship'
require_relative '../game_runner'

describe GameRunner do
  let(:subject) { GameRunner.new }

  describe '#initialize' do
    it 'creates two players' do
      expect(subject.players.count).to eq(2)
      subject
    end
  end
  describe '#run' do
    before do
      allow_any_instance_of(Object).to receive(:system)
      allow_any_instance_of(Object).to receive(:sleep)
      allow_any_instance_of(Object).to receive(:puts)
      allow(Board).to receive(:new).and_return(board)
      allow(Player).to receive(:new).and_return(player1, player2)
      allow(Ship).to receive(:new).and_return(ship)
      allow_any_instance_of(PlayRunner).to receive(:run).and_return('A1')
      allow(ship).to receive(:coordinates).and_return([])
      allow(subject).to receive(:valid_coordinates).and_return(true)
    end
    let(:board) do
      double('board',
             print: true,
             unhide_cases: true,
             rows: 5,
             columns: 5,
             check_placement: true,
             validate_placement: true)
    end
    let(:player1) { double('player1', greetings: true, pawn: '@', name: 'Mimi', ships: []) }
    let(:player2) { double('player2', greetings: true, pawn: '$', name: 'Momo', ships: []) }
    let(:ship) { double('ship', choose_coordinates: true, aligned?: true, sank?: true) }

    it 'greets the player' do
      expect(player1).to receive(:greetings).exactly(1).times
      expect(player2).to receive(:greetings).exactly(1).times
      subject.run
    end

    it 'allows each players to place his 2 ships' do
      expect(subject).to receive(:place_ship).with(size: 4, player: player1)
      expect(subject).to receive(:place_ship).with(size: 3, player: player1)
      expect(subject).to receive(:place_ship).with(size: 4, player: player2)
      expect(subject).to receive(:place_ship).with(size: 3, player: player2)
      subject.run
    end

    context 'when coordinates are invalid' do
      before do
        allow(subject).to receive(:valid_coordinates).and_return(false, false, true)
      end
      it 'asks the user to choose again' do
        expect(ship).to receive(:choose_coordinates).exactly(2).times
        subject.run
      end
      it 'validates board placement' do
        expect(board).to receive(:validate_placement).exactly(4).times
        subject.run
      end
      it 'adds ships to player ships' do
        expect { subject.run }.to change { player1.ships.count }.from(0).to(2)
      end
    end
  end
end
