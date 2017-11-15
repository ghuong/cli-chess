require "models/chess_board"

# Holds ALL state for the game
class ChessGameState
  attr_reader :id, :board, :current_player

  def initialize(id)
    @id = id
    @current_player = :white
    @board = ChessBoard.new
    @board.reset
    @kings = {
      black: @board.get_piece(7, 4),
      white: @board.get_piece(0, 4)
    }
  end

  def self.get_enemy_color(color)
    case color
    when :black
      :white
    when :white
      :black
    end
  end

  def switch_player
    @current_player = ChessGameState.get_enemy_color(@current_player)
  end

  def checkmate?(color)
    @kings[color].is_in_check? and @kings[color].get_moves.empty?
  end
end