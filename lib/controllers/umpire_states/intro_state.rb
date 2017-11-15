require "controllers/umpire_states/interactive_chess_state"
require "controllers/umpire_states/load_state"
require "controllers/umpire_states/play_state"

class IntroState < InteractiveChessState
  def display_intro
    puts "Welcome to Chess!"
    puts
  end

  def display_long_prompt
    puts "Commands:"
    puts " -- new (Starts a new game)"
    puts " -- load (Load saved games)" unless ChessStateHelpers.is_there_no_saved_games?
    puts " -- quit (Quit the program)"
    puts
  end

  def display_short_prompt
    print "Commands: new, "
    print "load, " unless ChessStateHelpers.is_there_no_saved_games?
    print "quit\n"
    puts
  end

  def process_input(command)
    case command
    when "new"
      transition_to_new_game_state
    when "load"
      if ChessStateHelpers.is_there_no_saved_games?
        super(command)
      else
        @context.set_state(LoadState.new(@context))
      end
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