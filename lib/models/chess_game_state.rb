require "models/chess_board"

# Holds ALL state for the game
class ChessGameState
  attr_reader :id, :board, :current_player

  def initialize(id)
    @id = id
    @current_player = :white
    @board = ChessBoard.new
    @board.reset
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
end