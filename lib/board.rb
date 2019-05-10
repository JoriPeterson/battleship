require './lib/cell'
require './lib/ship'
require 'pry'

class Board
  attr_reader :cells

  def initialize
    @cells = {
     "A1" => Cell.new("A1"),
     "A2" => Cell.new("A2"),
     "A3" => Cell.new("A3"),
     "A4" => Cell.new("A4"),
     "B1" => Cell.new("B1"),
     "B2" => Cell.new("B2"),
     "B3" => Cell.new("B3"),
     "B4" => Cell.new("B4"),
     "C1" => Cell.new("C1"),
     "C2" => Cell.new("C2"),
     "C3" => Cell.new("C3"),
     "C4" => Cell.new("C4"),
     "D1" => Cell.new("D1"),
     "D2" => Cell.new("D2"),
     "D3" => Cell.new("D3"),
     "D4" => Cell.new("D4")
     }
  end

  def valid_length?(ship, coordinate)
    ship.length == coordinate.length
  end

  # def valid_coordinates(coordinates)
  # end

  def consecutive?(ship, coordinate)
    horizontal.include?(coordinate) || vertical.include?(coordinate)
    # binding.pry
  end

  def horizontal
    # horizontal continuous:
    @cells.keys.each_cons(3).find_all do |values|
      values[0][0] == values[1][0] && values[0][0] == values[2][0]
    end
    # @cells.keys.each_cons(2).find do |values|
    #   values[0][0] == values[1][0]
    # end
  end

  def vertical
    # vertical continuous:

    coordinates_reversed = @cells.keys.map(&:reverse).sort.each_cons(3).find_all do |values|
      values[0][0] == values[1][0] && values[0][0] == values[2][0]
    end
    new_coords = []
    coordinates_reversed.each do |array|
      coord = []
      array.each do |coordinate|
        coord << coordinate.reverse
      end
      new_coords << coord
    end
    new_coords
  end
end
