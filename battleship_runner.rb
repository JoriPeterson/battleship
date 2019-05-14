require './lib/cell'
require './lib/ship'
require './lib/board'
require './setup'
require './turn'
# require 'main_menu'
require 'pry'

setup = Setup.new

# create a loop that takes a turn
# ends when the game is won or lost
  # when one of the boards has 5 sunk cells
    # counter?
turn = Turn.new(setup)

setup.main_menu

turn.display_boards
