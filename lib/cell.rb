require 'pry'

class Cell
  attr_reader :coordinate, :ship, :fired_upon

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

  def fired_upon?
    @fired_upon
  end

  def render
    if @fired_upon == false
      @coordinate = "."
    elsif @fired_upon == true && empty? == true
      @coordinate = "M"
    elsif @fired_upon == true && empty? == false
      @coordinate = "H"

    end
  end

end
