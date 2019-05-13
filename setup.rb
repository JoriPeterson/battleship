class Setup

  def computer_ship_placement
    # get random coordinates
      # check if placement is valid
    # place ships
  end

  def user_ship_placement
    p 'I have laid out my ships on the grid.'
    p 'You now need to lay out your two ships.'
    p 'The Cruiser is two units long and the Submarine is three units long.'
    p '  1 2 3 4'
    p 'A . . . .'
    p 'B . . . .'
    p 'C . . . .'
    p 'D . . . .'
    p 'Enter the squares for the Cruiser (3 spaces):'
    p '>'
    @user_cruiser_coords = gets.chomp
    p 'Enter the squares for the Submarine (2 spaces):'
    p '>'
    @user_submarine_coords = gets.chomp
    valid_cords

    # get user coordinates from input
      # check if placement is valid
    # place ships
      # after each ship is placed,
      # reveal placement to user with 'S'
  end

  def valid_user_coords
    # check if coords are valid
    # apply this method dynamically to user and computer coord input
    unless @user_cruiser_coords.valid_placement? && @user_submarine_coords.valid_placement?
      p 'Those are invalid coordinates. Please try again:'
      user_ship_placement
    end
  end

end
