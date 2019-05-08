require 'minitest/autorun'
require './lib/ship'
require 'minitest/pride'
require 'pry'

class ShipTest < Minitest::Test

  def setup
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists
    assert_instance_of Ship, @cruiser
  end

  def test_it_has_a_name_and_length
    assert_equal @cruiser.name, "Cruiser"
    assert_equal @cruiser.length, 3
  end

  def test_ship_has_initial_health
    assert_equal @cruiser.health, 3
  end

  def test_it_takes_a_hit
    @cruiser.hit
    assert @cruiser.health, 2
  end

  def test_it_sinks
    assert @cruiser.health, 3
    @cruiser.hit
    refute @cruiser.sunk?
    assert @cruiser.health, 2
    @cruiser.hit
    refute @cruiser.sunk?
    assert @cruiser.health, 1
    @cruiser.hit
    assert @cruiser.sunk?
  end

end
