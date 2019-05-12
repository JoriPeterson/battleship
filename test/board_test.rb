require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require 'pry'

class BoardTest < MiniTest::Test

  def setup
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @cell_1 = @board.cells["A1"]
    @cell_2 = @board.cells["A2"]
    @cell_3 = @board.cells["A3"]
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_cells_return_coordinates_and_cell_objects
    assert_equal 16, @board.cells.length
  end

  def test_ships_length_equals_coordinates_length
    refute @board.valid_length?(@cruiser, ["A1", "A2"])
    refute @board.valid_length?(@submarine, ["A2", "A3", "A4"])
  end

  def test_ships_coordinates_are_consecutive
    refute @board.consecutive?(@cruiser, ["A1", "A2", "A4"])
    refute @board.consecutive?(@submarine, ["A1", "C1"])
    refute @board.consecutive?(@cruiser, ["A3", "A2", "A1"])
    refute @board.consecutive?(@submarine, ["C1", "B1"])

    # check if horizontal cruiser has valid consecutive coordinates
    assert @board.consecutive?(@cruiser, ["A1", "A2", "A3"])
    # check if vertical cruiser has valid consecutive coordinates
    assert @board.consecutive?(@cruiser, ["A1", "B1", "C1"])
    # check if horizontal submarine has valid consecutive coordinates
    assert @board.consecutive?(@submarine, ["A1", "A2"])
    # check if vertical submarine has valid consecutive coordinates
    assert @board.consecutive?(@submarine, ["A1", "B1"])
  end

  def test_ships_coordinates_are_not_diagonal
    refute @board.consecutive?(@cruiser, ["A1", "B2", "C3"])
    refute @board.consecutive?(@submarine, ["C2", "D3"])
  end

  def test_ship_can_be_placed
    @board.place(@cruiser, ["A1", "A2", "A3"])
    assert_equal @cruiser, @cell_1.ship
    assert_equal @cruiser, @cell_2.ship
    assert_equal @cruiser, @cell_3.ship
    assert @cell_3.ship == @cell_2.ship
  end

  def test_ships_cannot_overlap
    @board.place(@cruiser, ["A1", "A2", "A3"])
    refute @board.valid_placement?(@submarine, ["A1", "B1"])
  end

  def test_board_visually_renders
    @board.place(@cruiser, ["A1", "A2", "A3"])
    # assert_equal "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n", @board.render

    assert_equal "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n", @board.render(true)
  end

end
