require "controllers/umpire_states/interactive_chess_state"
require "views/chess_view"

class PlayState < InteractiveChessState
  def initialize(context, game_data)
    super(context)
    @game_data = game_data
  end

  def display_intro
    puts "New game started."
  end

  def display_long_prompt
    DisplayChessBoard.display_board(@game_data.board)
    puts "Type 'quit' anytime to return to menu, or 'save' to save game."
    puts "Submit your commands by specifying two coordinates: the piece you want to move, and the space you want to go."
    puts "e.g. '1d 3d' will move the white pawn at 1d to 3d"
  end

  def display_short_prompt
    DisplayChessBoard.display_board(@game_data.board)
  end

  def display_prompt
    color = @game_data.current_player == :white ? "White" : "Black"
    puts "#{color} players turn: "
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