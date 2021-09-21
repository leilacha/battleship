# frozen_string_literal: true

# Check a coordinate
class CoordinateChecker
  def initialize(coordinate:, board_rows:, board_columns:)
    @coordinate = coordinate
    @board_rows = board_rows
    @board_columns = board_columns
  end

  def check
    return false unless @coordinate

    valid = true
    coordinates_array = @coordinate.split('')
    valid = false unless coordinates_array.size == 2
    coordinate_x = coordinates_array.first
    coordinate_y = coordinates_array.last.to_i
    valid = false unless coordinate_x.is_a?(String) && coordinate_y.is_a?(Integer)
    valid = false if coordinate_x.capitalize.ord - 65 >= @board_columns
    valid = false if (coordinate_x.capitalize.ord - 65).negative?
    valid = false if coordinate_y > @board_rows
    return true if valid

    puts "#{@coordinate} is not a valid coordinate. Please try again"
    false
  end
end
