require 'minitest/pride'
require './lib/cell'
require 'minitest/autorun'
require './lib/ship'
require 'pry'

class CellTest < MiniTest::Test

  def setup
    @cell = Cell.new("B4")
  end

  def test_it_exists
    assert_instance_of Cell, @cell
  end

  def test_it_has_attributes
    assert_equal "B4", @cell.coordinate
  end

  def test_no_ship_by_default
    assert_nil @cell.ship
  end

  def test_if_cell_is_empty
    assert @cell.empty?
  end

  def test_a_ship_is_placed
    cruiser = Ship.new("Cruiser", 3)
    @cell.place_ship(cruiser)
    assert_equal cruiser, @cell.ship
    refute @cell.empty?
  end

  def test_it_takes_fire
    cruiser = Ship.new("Cruiser", 3)

    @cell.place_ship(cruiser)
    refute @cell.fired_upon?
    @cell.fire_upon
    assert_equal @cell.ship.health, 2
    assert @cell.fired_upon?
    #
    # cruiser.hit
    # cruiser.sunk?
  end

end
