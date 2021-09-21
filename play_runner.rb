# frozen_string_literal: true

# Play a turn
class PlayRunner
  def initialize(player_name:, ships:, board:)
    @player_name = player_name
    @ships = ships
    @selected_coordinate = nil
    @board = board
  end

  def run
    puts "Hey #{@player_name}, it\'s your turn"
    puts 'Please choose a coordinate where to hit (ex A1, B4, C3) and press enter'
    until @board.check_coordinate(coordinate: @selected_coordinate)
      input = gets.chomp
      @selected_coordinate = input
    end
    ship_hit = hit_or_miss
    if ship_hit
      puts 'HIT !!' unless ship_hit.sank?
      puts 'SINK !!' if ship_hit.sank?
    else
      puts 'MISS !!'
    end
    @selected_coordinate
  end

  private

  def hit_or_miss
    hit = nil
    @ships.each do |ship|
      next unless ship.coordinates.include?(@selected_coordinate)

      ship.coordinates.delete(@selected_coordinate)
      hit = ship
      break
    end
    hit
  end
end
