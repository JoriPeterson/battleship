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

  def valid_length?(ship, coordinates)
    ship.length == coordinates.length
  end

  def consecutive?(ship, coordinates)
    if ship.length == 3
      horizontal_cruiser.include?(coordinates) || vertical_cruiser.include?(coordinates)
    else
      horizontal_submarine.include?(coordinates) || vertical_submarine.include?(coordinates)
    end
  end

  def horizontal_cruiser
    @cells.keys.each_cons(3).find_all do |values|
      values[0][0] == values[1][0] && values[0][0] == values[2][0]
    end
  end

  def horizontal_submarine
    @cells.keys.each_cons(2).find_all do |values|
      values[0][0] == values[1][0]
    end
  end

  def vertical_cruiser
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

  def vertical_submarine
    coordinates_reversed = @cells.keys.map(&:reverse).sort.each_cons(2).find_all do |values|
      values[0][0] == values[1][0]
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

  def place(ship, coordinates)
    if valid_length?(ship, coordinates) && consecutive?(ship, coordinates)

      coordinates.each do |cell_key|
        @cells[cell_key].place_ship(ship)  
      end
    end
  end

end
