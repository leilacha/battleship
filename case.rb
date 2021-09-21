# frozen_string_literal: true

# class for Case
class Case
  attr_accessor :pawn, :hidden
  attr_reader :x_axis, :y_axis

  def initialize(x_axis:, y_axis:)
    @x_axis = x_axis
    @y_axis = y_axis
    @pawn = nil
    @hidden = true
  end

  def empty?
    return true if @pawn.nil?

    puts "case #{to_coordinates} is not empty"
    false
  end

  def displayed_pawn(player_pawn:)
    no_display = @pawn != player_pawn && @hidden
    return 'o' if @pawn.nil? || no_display
    return 'x' if @pawn.nil? && !@hidden

    @pawn
  end

  def to_coordinates
    alphabet = ('A'..'Z').to_a
    "#{alphabet[@x_axis]}#{@y_axis + 1}"
  end
end
