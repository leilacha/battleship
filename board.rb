# frozen_string_literal: true

require 'pry'
require_relative 'case'

# class for Board
class Board
  def initialize(columns:, rows:)
    @columns = columns
    @rows = rows
    @cases = initialize_cases
  end

  def initialize_cases
    (0..@columns - 1).map do |x|
      (0..@rows - 1).map do |y|
        Case.new(x_axis: x, y_axis: y)
      end
    end.flatten
  end

  def print(player_pawn:)
    puts '########################'
    puts "  #{header.join(' ')}"
    (0..@rows - 1).each do |y|
      line = []
      line << (y + 1).to_s
      line << row(y_axis: y).map { |c| c.displayed_pawn(player_pawn: player_pawn) }
      puts line.join(' ')
    end
    puts '########################'
  end

  def check_placement(coordinates:)
    return false unless coordinates.any?

    selected_cases = coordinates.map do |coordinate|
      fetch_case(coordinate: coordinate)
    end
    return false unless selected_cases.all?(&:empty?)

    selected_cases
  end

  def validate_placement(coordinates:, pawn:)
    selected_cases = coordinates.map do |coordinate|
      fetch_case(coordinate: coordinate)
    end
    selected_cases.each { |c| c.pawn = pawn }
  end

  def unhide_cases(coordinates:)
    selected_cases = coordinates.map do |coordinate|
      fetch_case(coordinate: coordinate)
    end
    selected_cases.each { |c| c.hidden = false }
  end

  private

  def fetch_case(coordinate:)
    begin
      x_axis = header.index(coordinate.split('').first)
      y_axis = coordinate.split('').last.to_i - 1
    rescue StandardError
      puts 'wrong coordinates!!!'
      return false
    end
    find_case_by(x_axis: x_axis, y_axis: y_axis)
  end

  def find_case_by(x_axis:, y_axis:)
    @cases.select { |c| c.x_axis == x_axis && c.y_axis == y_axis }.last
  end

  def header
    alphabet = ('A'..'Z').to_a
    alphabet[0..@columns - 1]
  end

  def row(y_axis:)
    @cases.select { |c| c.y_axis == y_axis }.sort_by(&:x_axis)
  end
end
# Board.new(columns: 5, rows: 5).validate_placement(coordinates: %W[B2 B3 B4	])
