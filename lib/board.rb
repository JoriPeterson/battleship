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

  # make tests for this method
  def valid_coordinate?(coordinate)
    @cells.keys.include? coordinate
  end

  def valid_placement?(ship, coordinates)

    valid_coordinates = coordinates.all? do |coord|
      valid_coordinate?(coord)
    end
    if valid_coordinates
    valid_length = valid_length?(ship, coordinates)
    consecutive = consecutive?(ship, coordinates)
    not_overlap = not_overlap?(coordinates)
    # is_valid = valid_coordinates == coordinates
    valid_length && consecutive && not_overlap && valid_coordinates
    else
      false
    end
    # p 'These were the values for valid length:', valid_length
    # p 'These were the values for consecutive:', consecutive
    # p 'These were the values for not overlap:', not_overlap
    # p 'These were the values for valid coord:', valid_coordinate
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

  def not_overlap?(coordinates)
      coordinates.each do |coordinate|
        if @cells[coordinate].empty? == false
          break
        end
      end

  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |cell_key|
        @cells[cell_key].place_ship(ship)
      end
      true
    else
      # raise ArgumentError "Oh, those coordinates aren't valid"
      false
    end
  end

  def render(show_ship=false)

    rows = Math.sqrt(@cells.keys.length).to_i
    columns = rows

    rr = " "
    #rr = rendered_rows

      (1..columns).to_a.each do |header|
        rr += " #{header}"
      end
      rr += " \n"

      ('A'..'D').to_a.each_with_index do |sider, index|
        rr += "#{sider}"
            @cells.keys[index * columns..(index * columns) + columns - 1].each do |key|
            rr += " #{@cells[key].render(show_ship)}"
          end
        rr += " \n"
      end
      rr
  end
end
