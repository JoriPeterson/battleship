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
until turn.end_game
  turn.player_shot
  turn.computer_shot
  turn.display_boards
end
