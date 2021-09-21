# frozen_string_literal: true

# class for Ship
class Ship
  attr_reader :size
  attr_accessor :coordinates

  def initialize(size:)
    @size = size
    @coordinates = []
  end

  def choose_coordinates
    @coordinates = []
    puts "Please choose #{@size} following coordinates to place your ship. ex A1, B1, C1"
    puts 'Press enter after each coordinates'
    until @coordinates.size == @size
      input = gets.chomp
      @coordinates << input
      @coordinates.compact.uniq!
    end
  end

  def aligned?
    return false if @coordinates.empty?

    horizontal = @coordinates.map { |c| c.split('').first.ord }.uniq.sort
    vertical = @coordinates.map { |c| c.split('').last.to_i }.uniq.sort
    horizontally_aligned = vertical.size == 1 && incremental?(horizontal)
    vertically_aligned = horizontal.size == 1 && incremental?(vertical)
    return true if horizontally_aligned || vertically_aligned

    puts 'The ship is not on following cases'
    false
  end

  def sank?
    @coordinates.empty?
  end

  private

  def incremental?(array)
    array.each_cons(2).all? { |x, y| y == x + 1 }
  end
end
