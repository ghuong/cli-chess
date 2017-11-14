require "models/chess_game_state"
require "controllers/chess_state_helpers"

# State Context (using the State pattern) for the chess game
class InteractiveChessStateContext
  def initialize
    set_state(IntroState.new(self))
  end

  # called only by the chess states
  def set_state(state)
    @state = state
  end

  # this is only for testing purposes
  def get_state
    @state
  end

  def display_prompt
    @state.display_prompt
  end

  def process_input(command)
    @state.process_input(command)
  end
end

class InteractiveChessState
include ChessStateHelpers

  def initialize(context)
    @context = context
    @should_display_long_prompt = true
    display_intro
  end

  # Display message prompting for input
  def display_prompt
    if @should_display_long_prompt
      display_long_prompt
      @should_display_long_prompt = false
    else
      display_short_prompt
    end
    display_prompt_sign
  end

  # Display intro message upon transitioning to state
  def display_intro; end
  # Display long-version of prompt
  def display_long_prompt; end
  # Display short-version of prompt
  def display_short_prompt
    display_long_prompt
  end
  def display_prompt_sign
    print " > "
  end
  # Process user input
  def process_input(command)
    ChessStateHelpers.display_invalid_command_warning
  end
end

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

class LoadState < InteractiveChessState
  def display_long_prompt
    puts "Saved games:"
    saved_games = GameSaver.get_list_of_saved_games
    saved_games.each do |game|
      puts " -- #{game[:id]}: #{game[:title]}"
    end
  end

  def display_prompt_sign
    print "Type game ID (or 'back' to return): "
  end

  def process_input(command)
    case command
    when "back"
      @context.set_state(IntroState.new(@context))
    else
      id = command.to_i
      game_data = GameSaver.load_game_by_id(id)
      if not game_data.nil?
        @context.set_state(PlayState.new(@context, game_data))
      else
        puts "Sorry, '#{command}' is not a valid game ID."
      end
    end
  end
end

class PlayState < InteractiveChessState
  def initialize(context, game_data)
    super(context)
    @game_data = game_data
  end

  def display_intro
    puts "New game started. Type 'quit' anytime to return to menu, or 'save' to save game."
  end

  def display_long_prompt
    raise "Not implemented"
  end

  def process_input(command)
    case command
    when "quit"
      @context.set_state(IntroState.new(@context))
    when "save"
      @context.set_state(SaveState.new(@context, self))
    else
      raise "Not implemented"
    end
  end

  def get_game_data
    @game_data
  end
end

class SaveState < InteractiveChessState
  def initialize(context, current_play_state)
    super(context)
    @current_play_state = current_play_state
  end

  def display_long_prompt
    puts "Enter a name for your game: "
  end

  def process_input(game_title)
    game_data = @current_play_state.get_game_data
    GameSaver.save_game(game_data.id, game_title, game_data)
    @context.set_state(@current_play_state)
    puts "Your game '#{game_title}' has been saved!"
  end
end
