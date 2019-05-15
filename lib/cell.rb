require 'pry'

class Cell
  attr_reader :coordinate, :ship, :fired_upon, :s

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def fire_upon
    if empty?
      @fired_upon = true
    elsif empty? == false
      @ship.hit
      @fired_upon = true
    end
  end

  def ord
    @coordinate[0].ord.to_s  + @coordinate[1]
  end

  def fired_upon?
    @fired_upon
  end

  def render(show_ship=false)
    if @fired_upon == true && empty?
      @coordinate = "M"
    elsif @fired_upon == true && !empty? && @ship.sunk? == false
      @coordinate = "H"
    elsif @fired_upon == false && empty?
      @coordinate = "."
    elsif @fired_upon == false && !empty?

      if show_ship == true
        @coordinate = "S"
      else
        @coordinate = "."
      end

    elsif @ship.sunk?
      @coordinate = "X"
    end
  end

end
