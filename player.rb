# frozen_string_literal: true

# class for Player
class Player
  attr_accessor :name, :ships
  attr_reader :pawn

  def initialize(pawn:, code:)
    @pawn = pawn
    @code = code
    @ships = []
  end

  def greetings
    puts "Hi #{@code}, what\'s your name?"
    @name = gets.chomp.capitalize
    puts "Hi #{@name}"
  end
end
