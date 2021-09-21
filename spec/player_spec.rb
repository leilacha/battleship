# frozen_string_literal: true

require 'spec_helper'
require_relative '../player'

describe Player do
  let(:player) { Player.new(pawn: '&', code: 'my_player') }
  describe '#initialize' do
    it 'initializes attributes' do
      expect(player.pawn).to eq('&')
      expect(player.name).to eq('')
      expect(player.ships).to eq([])
    end
  end

  describe '#greetings' do
    before do
      io_obj = double
      expect(player)
        .to receive(:gets)
        .and_return(io_obj)
      expect(io_obj)
        .to receive(:chomp)
        .and_return('Michel')
    end

    let(:greetings) do
      "Hi my_player, what\'s your name?\n"\
      "Hi Michel, your pawn will be &\n"
    end

    it 'greets the player' do
      expect { player.greetings }.to output(greetings).to_stdout
    end
  end
end
