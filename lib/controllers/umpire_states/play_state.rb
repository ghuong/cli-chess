require "controllers/umpire_states/interactive_chess_state"
require "views/chess_view"

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