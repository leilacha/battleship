# frozen_string_literal: true

require 'pry'

# Play a turn
class PlayRunner
  def initialize(player:, ships:)
    @player = player
    @ships = ships
    @selected_coordinate = nil
  end

  def run
    puts "Hey #{@player.name}, it\'s your turn"
    puts 'Please choose a coordinate where to hit (ex A1, B4, C3) and press enter'
    @selected_coordinate = gets.chomp
    ship_hit = hit_or_miss
    if ship_hit
      puts 'HIT !!' if ship_hit.coordinates.any?
      puts 'SINK !!' if ship_hit.coordinates.empty?
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
