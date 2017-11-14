require "controllers/umpire_states/interactive_chess_state"

class IntroState < InteractiveChessState
  def initialize(context)
    super(context)
    if ChessStateHelpers.is_there_no_saved_games?
      transition_to_new_game_state
    end
  end

  def display_intro
    puts "Welcome to Chess!"
    puts
  end

  def display_long_prompt
    puts "Commands:"
    puts " -- new (Starts a new game)"
    puts " -- load (Load saved games)"
    puts " -- quit (Quit the program)"
    puts
  end

  def display_short_prompt
    puts "Commands: new, load, quit"
    puts
  end

  def process_input(command)
    case command
    when "new"
      transition_to_new_game_state
    when "load"
      @context.set_state(LoadState.new(@context))
    when "quit"
      return "quit"
    else
      super(command)
    end
  end

  def transition_to_new_game_state
    @context.set_state(PlayState.new(@context, ChessStateHelpers.get_new_game))
  end
end