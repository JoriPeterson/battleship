require './lib/cell'
require './lib/ship'
require './lib/board'
require './setup'
require './turn'
require 'pry'

setup = Setup.new
turn = Turn.new(setup)
setup.main_menu
turn.display_boards
