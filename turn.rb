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
    
  end

  def player_shot
    p 'Enter a coordinate to fire upon:'
    p '>'
    answer = gets.chomp.upcase
    if @setup.computer_board.valid_coordinate?(answer)
      if @setup.computer_board.cells[answer].fired_upon?
       p "Oh no! You already fired on that cell!"
       player_shot

      else
       @setup.computer_board.cells[answer].fire_upon
       @last_player_shot = answer
      end
    else
      p 'That is an invalid coordinate. Please enter a valid coordinate:'
      player_shot
    end
  end

  def computer_shot
    unfired_upon_player_cells = @setup.player_board.cells.select do | key, cell | !cell.fired_upon?
    end

    comp_shot = unfired_upon_player_cells.keys.sample
    player_cell = @setup.player_board.cells[comp_shot]
    player_cell.fire_upon

    computer_cell = @setup.computer_board.cells[@last_player_shot]

    player_shot_status = 'miss'
    if computer_cell.ship && computer_cell.ship.sunk?
      player_shot_status = "sinker"
    elsif !computer_cell.empty?
      player_shot_status = "hit"
    end

    computer_shot_status = 'miss'
    if player_cell.ship && player_cell.ship.sunk?
      player_shot_status = "sinker"
    elsif !player_cell.empty?
      computer_shot_status = 'hit'
    end

    p "The player's shot on #{@last_player_shot} was a #{player_shot_status}"
    p "The computer shot on #{comp_shot} was a #{computer_shot_status}"
    end

  def end_game
    if @setup.computer_cruiser.sunk? && @setup.computer_submarine.sunk?
      puts  "YOU WON DO A HAPPY DANCE"

      @setup.main_menu

    elsif @setup.player_cruiser.sunk? && @setup.player_submarine.sunk?
      puts 'YOU LOST BOOHOO'

      @setup.main_menu
    else
    end
  end
end
