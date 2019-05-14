require './lib/cell'
require './lib/ship'
require './lib/board'
require 'pry'

class Setup

  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @player_cruiser = Ship.new('cruiser', 3)
    @player_submarine = Ship.new('submarine', 2)
    @computer_cruiser = Ship.new('cruiser', 3)
    @computer_submarine = Ship.new('submarine', 2)
  end

  def main_menu
    # system clear
    # make reset method to restart game
    # reset
    p 'Welcome to BATTLESHIP'
    p 'Enter p to play. Enter q to quit.'
    @answer = gets.chomp
    if @answer == 'p'
      computer_ship_placement
    else
      p 'okay byeeeee'
    end
  end

  def computer_ship_placement
    # get random coordinates >>
      #cruisercoords
    cruiser_coords = []
    unless cruiser_coords.length >= 3
      random_ship_coords = @computer_board.cells.keys.shuffle.sample
      cruiser_coords << random_ship_coords
    end

      # submarine coords
    submarine_coords = []
    unless submarine_coords.length >= 2
      random_ship_coords = @computer_board.cells.keys.shuffle.sample
      submarine_coords << random_ship_coords
    end

    # place ships >>
      # placecruiserusingcruisercoords
      @computer_board.place(@computer_cruiser, cruiser_coords)
    # check if placement is valid
      @computer_board.valid_placement?(@computer_cruiser, cruiser_coords)

    # place submarine using submarine coords
      @computer_board.place(@computer_submarine, submarine_coords)
    # check if placement is valid
      @computer_board.valid_placement?(@computer_submarine, submarine_coords)

    # render the board with coordinates
      @computer_board.render(false)
      get_user_coords
  end

  def get_user_coords
    p 'I have laid out my ships on the grid.'
    p 'You now need to lay out your two ships.'
    p 'The Cruiser is three units long and the Submarine is two units long.'
    p '  1 2 3 4'
    p 'A . . . .'
    p 'B . . . .'
    p 'C . . . .'
    p 'D . . . .'
    p 'Enter the squares for the Cruiser (3 spaces):'

    # get user coordinates from input
    placed = false
    while !placed
      user_cruiser_coords = []
      (1..@player_cruiser.length).each do
        print '> '
        user_cruiser_coords << gets.chomp.to_s
      end

      placed = @player_board.place(@player_cruiser, user_cruiser_coords)
      if !placed
        p "Oh, those coordinates aren't valid"
        p "Please enter coordinates"
      end
    end

    p "You have entered coordinates: #{user_cruiser_coords}"
    show_user_board
    p 'Enter the squares for the Submarine (2 spaces):'
    p '>'
    placed = false
    while !placed
      user_submarine_coords = []
      (1..@player_submarine.length).each do
        print '> '
        user_submarine_coords << gets.chomp.to_s
      end

      placed = @player_board.place(@player_submarine, user_submarine_coords)
      if !placed
        p "Oh, those coordinates aren't valid"
        p "Please enter coordinates"
      end
    end
    show_user_board
    # check if placement is valid
  end


    # show player their board and placed ships
    def show_user_board
      puts @player_board.render(true)
    end

  def valid_user_coords(user_cruiser_coords, user_submarine_coords)
    # check if coords are valid
    # apply this method dynamically to user and computer coord input
    unless @player_board.valid_placement?(@player_cruiser, user_cruiser_coords) &&
      @player_board.valid_placement?(@player_submarine, user_submarine_coords)
      p 'Those are invalid coordinates. Please try again:'
      get_user_coords
    end
  end

end
