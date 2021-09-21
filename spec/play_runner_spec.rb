# frozen_string_literal: true

require 'spec_helper'
require_relative '../player'
require_relative '../play_runner'
require_relative '../ship'
require_relative '../board'

describe PlayRunner do
  let(:ship1) { Ship.new(size: 3) }
  let(:ship2) { Ship.new(size: 4) }
  let(:board) { Board.new(columns: 5, rows: 5) }
  let(:ships) { [ship1, ship2] }
  let(:subject) { PlayRunner.new(player_name: 'Johnny', ships: ships, board: board) }
  before do
    io_obj = double
    expect(subject)
      .to receive(:gets)
      .and_return(io_obj)
    expect(io_obj)
      .to receive(:chomp)
      .and_return(user_coordinate)
    ship1.coordinates = %w[A1 A2 A3]
    ship2.coordinates = ['E1']
  end
  let(:greetings) do
    "Hey Johnny, it's your turn\nPlease choose a coordinate where to hit (ex A1, B4, C3) "\
    "and press enter\n"
  end
  describe '#run' do
    let(:user_coordinate) { 'C2' }
    context 'when ship is missed' do
      it 'puts MISS' do
        expect { subject.run }.to output("#{greetings}MISS !!\n").to_stdout
      end
    end
    context 'when ship is hit' do
      context 'when ship has not sank' do
        let(:user_coordinate) { 'A1' }
        it 'puts HIT' do
          expect { subject.run }.to output("#{greetings}HIT !!\n").to_stdout
        end
      end
      context 'when ship has sank' do
        let(:user_coordinate) { 'E1' }
        it 'puts SINK' do
          expect { subject.run }.to output("#{greetings}SINK !!\n").to_stdout
        end
      end
    end
  end
end
