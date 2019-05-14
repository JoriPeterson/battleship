class MainMenu

  def start
    p 'Welcome to BATTLESHIP'
    p 'Enter p to play. Enter q to quit.'
    @answer = gets.chomp
    start_or_quit_game
  end

  def start_or_quit_game
    # if @answer == 'p'
    #   start game
    # elsif @answer == 'q'
    #   quit game
    # end
  end
  start
end
