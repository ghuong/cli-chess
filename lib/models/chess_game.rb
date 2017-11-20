require "models/chess_board"
require "utilities/constants"

# Holds ALL state for the game
class ChessGame
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

  def switch_player
    @current_player = ChessGame.get_enemy_color(@current_player)
  end

  def checkmate?(color)
    @kings[color].is_in_check? and @kings[color].get_moves.empty?
  end

  def can_move?(start_row, start_col, destination_row, destination_col)
    start_row, start_col = ChessBoardHelpers.conventional_coordinates_to_indices(start_row, start_col)
    destination_row, destination_col = ChessBoardHelpers.conventional_coordinates_to_indices(destination_row, destination_col)
    @board.can_move?(start_row, start_col, destination_row, destination_col, @current_player)
  end

  def move(start_row, start_col, destination_row, destination_col)
    start_row, start_col = ChessBoardHelpers.conventional_coordinates_to_indices(start_row, start_col)
    destination_row, destination_col = ChessBoardHelpers.conventional_coordinates_to_indices(destination_row, destination_col)
    @board.move(start_row, start_col, destination_row, destination_col)
  end

  # Returns true iff the King of the given 'color' can castle with its rook on the
  # left or right, as given by the 'direction' parameter
  def can_castle?(color, direction)
    rook_col = direction == :left ? 0 : ChessBoardConstants::BOARD_DIMENSIONS - 1
    rook_row = color == :white ? 0 : ChessBoardConstants::BOARD_DIMENSIONS - 1
    rook = @board.get_piece(rook_row, rook_col)
    spaces_inbetween = []
    case direction
    when :left
      spaces_inbetween = [1, 2, 3]
    when :right
      spaces_inbetween = [5, 6]
    end
    is_empty_inbetween = spaces_inbetween.all? do |col|
      @board.get_piece(rook_row, col).is_blank_space?
    end

    return (rook.get_type == :rook and not rook.has_moved and not @kings[color].has_moved and
            is_empty_inbetween and not @kings[color].is_in_check?)
  end

  def self.get_enemy_color(color)
    case color
    when :black
      :white
    when :white
      :black
    end
  end
end