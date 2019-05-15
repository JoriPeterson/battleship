require './lib/cell'
require './lib/ship'
require './lib/board'
require 'pry'

class Setup
  attr_reader :computer_board, :player_board

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
    answer = gets.chomp
    if answer == 'p'
      computer_ship_placement
    else
      p 'okay byeeeee'
    end
  end

  def next_column(coords)
    last_coord = coords.last
    # p last_coord
    new_num = last_coord[1].to_i + 1

    last_coord[0] + new_num.to_s
  end

  def prev_column(coords)
    first_coord = coords.first
    # p first_coord
    new_num = first_coord[1].to_i - 1

    first_coord[0] + new_num.to_s
  end

  def next_row(coords)
    last_coord = coords.last
    new_letter = last_coord[0].next

    new_letter + last_coord[1]
  end

  def prev_row(coords)
    first_coord = coords.first
    new_letter = (first_coord[0].ord-1).chr

    new_letter + first_coord[1]
  end

  def generate_coords(ship_length)
    coords = []
    random_num = rand()
    is_horizontal = random_num > 0.5
    is_vertical = random_num < 0.5

    until coords.length == ship_length
      # binding.pry
      if coords.length == 0
        random_ship_coord = @computer_board.cells.keys.sample
        # p 'testing cruiser coord', random_ship_coord
        if @computer_board.valid_coordinate?(random_ship_coord)
          coords << random_ship_coord
        end
      elsif is_horizontal
        new_coord = next_column(coords)
        if @computer_board.valid_coordinate?(new_coord)
          coords << new_coord
        else
          new_coord = prev_column(coords)
          coords.unshift(new_coord)
        end

      elsif is_vertical
        new_coord = next_row(coords)
        if @computer_board.valid_coordinate?(new_coord)
          coords << new_coord
        else
          new_coord = prev_row(coords)
          coords.unshift(new_coord)
        end
      end
    end
    p 'testing loop', coords

    coords
  end

  def computer_ship_placement
    # get random coordinates >>
      # cruisercoords

    cruiser_coords = generate_coords(3)
    #   # submarine coords
    # submarine_coords = []
    # until submarine_coords.length == 2
    #   random_ship_coord = @computer_board.cells.keys.sample
    #   # p 'testing submarine coord', random_ship_coord
    #   if @computer_board.valid_coordinate?(random_ship_coord)
    #     submarine_coords << random_ship_coord
    #   end
    # end

    # place ships >>
      # place cruiser using cruiser coords
    @computer_board.place(@computer_cruiser, cruiser_coords)
      # binding.pry
    # check if placement is valid
      # @computer_board.valid_placement?(@computer_cruiser, cruiser_coords)

    # place submarine using submarine coords
    placed = false
    while !placed
      submarine_coords = generate_coords(2)
      p 'try to create coords', submarine_coords
      placed = @computer_board.place(@computer_submarine, submarine_coords)
    end
    # check if placement is valid
      # @computer_board.valid_placement?(@computer_submarine, submarine_coords)

    # render the board with coordinates
      puts @computer_board.render(false)
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
    # display_boards
    # check if placement is valid
  end

  # show player their board and placed ships
  def show_user_board
    puts @player_board.render(true)
  end

  def show_computer_board
    puts @computer_board.render(false)
  end

  # def display_boards
  #   p '============ AI BOARD =========='
  #   puts @computer_board.render(false)
  #   p '============ USER BOARD =========='
  #   puts show_user_board
  # end


end
