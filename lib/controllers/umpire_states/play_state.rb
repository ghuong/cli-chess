require "controllers/umpire_states/interactive_chess_state"
require "controllers/umpire_states/intro_state"
require "views/chess_view"

class PlayState < InteractiveChessState
  def initialize(context, game_data)
    super(context)
    @game_data = game_data
  end

  def display_intro
    puts "New game started."
    puts
  end

  def display_long_prompt
    DisplayChessBoard.display_board(@game_data.board)
    puts
    puts "Type 'quit' anytime to return to menu, or 'save' to save game."
    puts "Submit your commands by specifying two coordinates: the piece you want to move, and the space you want to go."
    puts "e.g. '2d 4d' will move the white pawn at 2d to 4d."
    puts
  end

  def display_short_prompt
    DisplayChessBoard.display_board(@game_data.board)
    puts
  end

  def display_prompt_sign
    color = @game_data.current_player == :white ? "White" : "Black"
    print "#{color} players turn: "
  end

  def process_input(command)
    case command
    when "quit"
      @context.set_state(IntroState.new(@context))
    when "save"
      @context.set_state(SaveState.new(@context, self))
    else
      coords = command.gsub(/[\s,]+/, "")
      if coords.length == 4
        start_row, start_col = ChessBoardHelpers.conventional_coordinates_to_indices(coords[0], coords[1])
        destination_row, destination_col = ChessBoardHelpers.conventional_coordinates_to_indices(coords[2], coords[3])
        if @game_data.board.can_move?(start_row, start_col, destination_row, destination_col, @game_data.current_player)
          @game_data.board.move(start_row, start_col, destination_row, destination_col)
          if @game_data.checkmate? ChessGameState.get_enemy_color(@game_data.current_player)
            return @game_data.current_player.to_s
          end
          @game_data.switch_player
          return
        end
      end
      puts "Sorry, that move is not valid."
      puts
    end
  end

  def get_game_data
    @game_data
  end
end