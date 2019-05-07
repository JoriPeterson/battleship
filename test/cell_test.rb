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
    @cruiser = Ship.new("Cruiser", 3)
    assert @cell.empty?
  end

  def test_it_has_a_ship
    skip
    assert_instance_of Ship, @ship
  end




end
