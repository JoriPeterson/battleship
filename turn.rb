require './lib/cell'
require './lib/ship'
require './lib/board'
require './setup'
require 'pry'

class Turn
  def initialize(setup)
    @setup = setup
    @last_player_shot
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
    answer = gets.chomp.upcase

    if @setup.computer_board.valid_coordinate?(answer)
      @setup.computer_board.cells[answer].fire_upon
      @last_player_shot = answer

      computer_shot
    else
      p 'That is an invalid coordinate. Please enter a valid coordinate:'
      player_shot
    end
  end

    def computer_shot
      # display_boards
      comp_shot = @setup.player_board.cells.keys.sample
      cell = @setup.player_board.cells[comp_shot]
        if cell.fired_upon? == false
          cell.fire_upon
        end

      player_cell = @setup.computer_board.cells[@last_player_shot]

    p "Your shot on #{@last_player_shot} was a #{player_cell.coordinate}"
    # require 'pry'; binding.pry
    p "My shot on #{comp_shot} was a #{cell.coordinate}"

    display_boards
  end

end
