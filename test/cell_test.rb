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
  end

  def test_renders_returns_empty_or_miss
    @cell.render
    # "." = ship not fired upon
    assert_equal ".", @cell.render
    @cell.fire_upon
    @cell.render
    # "M" = ship fired upon & missed
    assert_equal "M", @cell.render
  end

  def test_ship_two_renders_sunk_and_hit
    cruiser = Ship.new("Cruiser", 3)
    cell_2 = Cell.new("B4")

    cell_2.place_ship(cruiser)
    assert_equal ".", cell_2.render
    # "S" = reveal ship placement but it has not been fired upon
    assert_equal "S", cell_2.render(true)
    cell_2.fire_upon
    # "H" = ship hit
    assert_equal "H", cell_2.render
    refute cruiser.sunk?
    cruiser.hit
    cruiser.hit
    assert cruiser.sunk?
    # "X" = ship has sunk
    assert_equal "X", cell_2.render
  end


end
