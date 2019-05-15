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
    # This filters down the player cells hash to cells that haven't
    # yet been fired upon
    unfired_upon_player_cells = @setup.player_board.cells.select do | key, cell | !cell.fired_upon?
    end
    # Get a random cell key that hasn't been fired on yet
    comp_shot = unfired_upon_player_cells.keys.sample
    player_cell = @setup.player_board.cells[comp_shot]
    player_cell.fire_upon

    computer_cell = @setup.computer_board.cells[@last_player_shot]

    player_shot_status = 'miss'
    if @setup.computer_cruiser.sunk? || @setup.computer_submarine.sunk?
      player_shot_status = "sinker"
    elsif !computer_cell.empty?
      player_shot_status = "hit"
    end

    computer_shot_status = 'miss'
    if @setup.player_cruiser.sunk? || @setup.player_submarine.sunk?
      player_shot_status = "sinker"
    elsif !player_cell.empty?
      computer_shot_status = 'hit'
    end

    p "The player's shot on #{@last_player_shot} was a #{player_shot_status}"
    # require 'pry'; binding.pry
    p "The computer shot on #{comp_shot} was a #{computer_shot_status}"

    display_boards
  end

end
