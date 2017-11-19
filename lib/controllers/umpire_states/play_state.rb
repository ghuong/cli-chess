require "controllers/umpire_states/umpire_state"
require "controllers/umpire_states/intro_state"
require "controllers/umpire_states/save_state"
require "views/display"

class PlayState < UmpireState
  def initialize(game)
    @game = game
  end

  def display_intro
    puts "New game started."
    puts
  end

  def display_long_prompt
    Display.display_game(@game)
    puts
    puts "Type 'quit' anytime to return to menu, or 'save' to save game."
    puts "Submit your commands by specifying two coordinates: the piece you want to move, and the space you want to go."
    puts "e.g. '2d 4d' will move the white pawn at 2d to 4d."
    puts
  end

  def display_short_prompt
    Display.display_game(@game)
    puts
  end

  def display_prompt_sign
    color = @game_data.current_player == :white ? "White" : "Black"
    print "#{color} players turn: "
  end

  def process_input(context, command)
    case command
    when "quit"
      context.set_state(IntroState.new)
    when "save"
      context.set_state(SaveState.new(self))
    else
      process_move(context, command)
    end
  end

  def process_move(context, command)
    coords = command.gsub(/[\s,]+/, "")
    if coords.length != 4
      puts "Sorry, that input was invalid."
      puts
    end

    start_row, start_col, destination_row, destination_col = coords
    if @game.can_move?(start_row, start_col, destination_row, destination_col)
      @game_data.move(start_row, start_col, destination_row, destination_col)
      if @game_data.checkmate? ChessGameState.get_enemy_color(@game_data.current_player)
        Display.display_board(@game_data.board)
        puts
        return @game_data.current_player.to_s
      end
      @game_data.switch_player
      return
    else
      puts "Sorry, that move in invalid."
      puts
    end
  end

  # For testing
  def get_game
    @game
  end
end