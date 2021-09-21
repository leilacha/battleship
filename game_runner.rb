# frozen_string_literal: true

require_relative 'player'
require_relative 'case'
require_relative 'board'
require_relative 'ship'
require_relative 'play_runner'
require 'pry'

# Play the game
class GameRunner
  def initialize
    @board = Board.new(columns: 7, rows: 5)
    @players = initialize_players
  end

  def run
    place_ships
    until @win
      @players.each do |player|
        opponent = @players - [player]
        play(player: player, opponent: opponent.last)
        sleep(5)
        break if @win
      end
    end
    # loop do
    #   play(player: @player1, opponent: @player2)
    #   break if @win
    #   sleep(5)
    #   play(player: @player2, opponent: @player1)
    #   break if @win
    #   sleep(5)
    # end
    post_game
  end

  private

  def initialize_players
    @player1 = Player.new(code: 'player1', pawn: '$')
    @player2 = Player.new(code: 'player2', pawn: '@')
    [@player1, @player2]
  end

  def place_ships
    @players.each do |player|
      player.greetings
      puts "Hey #{player.name}, let\'s place your first ship"
      # place_ship(size: 4, player: player)
      puts "#{player.name}, let\'s place your second ship"
      place_ship(size: 3, player: player)
      system 'clear'
    end
  end

  def place_ship(size:, player:)
    @board.print(player_pawn: player.pawn)
    ship = Ship.new(size: size)
    ship.choose_coordinates until ship.aligned? && @board.check_placement(coordinates: ship.coordinates)
    @board.validate_placement(coordinates: ship.coordinates, pawn: player.pawn)
    player.ships << ship
    puts 'Ship is placed!!'
  end

  def play(player:, opponent:)
    system 'clear'
    @board.print(player_pawn: player.pawn)
    ships = opponent.ships
    selected_coordinate = PlayRunner.new(player: player, ships: ships).run
    @board.unhide_cases(coordinates: [selected_coordinate])
    @board.print(player_pawn: player.pawn)
    @win = ships.all?(&:sank?)
    return unless @win

    @board.print(player_pawn: player.pawn)
    puts "Bravo #{player.name}, you won!!!!"
  end

  def post_game
    reset_game
  end

  def reset_game
    puts 'wanna play again? (Y/N)'
  end
end

GameRunner.new.run
