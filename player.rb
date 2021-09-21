# frozen_string_literal: true

# class for Player
class Player
  attr_accessor :ships
  attr_reader :name, :pawn

  def initialize(pawn:, code:)
    @pawn = pawn
    @code = code
    @name = ''
    @ships = []
  end

  def greetings
    puts "Hi #{@code}, what\'s your name?"
    @name = gets.chomp.capitalize
    puts "Hi #{@name}, your pawn will be #{@pawn}"
  end
end
