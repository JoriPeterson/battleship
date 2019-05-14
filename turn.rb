require './lib/cell'
require './lib/ship'
require './lib/board'
require './setup'
require 'pry'

class Turn
  def initialize(setup)
    @setup = setup
  end

  def display_boards
    p "============ AI BOARD =========="

    puts @setup.show_computer_board

    p "============ USER BOARD =========="
    puts @setup.show_user_board
    player_shot
  end

  def player_shot
    p 'Enter a coordinate to fire upon:'
    p '>'
    answer = gets.chomp

    if @setup.computer_board.valid_coordinate?(answer)

      @setup.computer_board.cells[answer].fire_upon
      #computer_shot
      #computer shot will call display boards
      display_boards
    else
      p 'That is an invalid coordinate. Please enter a valid coordinate:'
      player_shot
    end
  end

end
