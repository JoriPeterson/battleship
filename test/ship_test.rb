require 'minitest/autorun'
require './lib/ship'
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

  # def test_cruiser_has_an_initial_health
  #   assert_equal @cruiser.health, 3
  # end

end
