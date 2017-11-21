require "models/chess_board"
require "utilities/constants"

# Holds ALL state for the game
class ChessGame
  attr_reader :id, :board

  def initialize(id)
    @id = id
    @board = ChessBoard.new
    @board.reset
    @kings = {
      black: @board.get_piece(7, 4),
      white: @board.get_piece(0, 4)
    }
  end

  def get_current_player
    case (@board.turn % 2)
    when 0
      :white
    when 1
      :black
    end
  end

  def checkmate?(color)
    @kings[color].is_under_attack? and @kings[color].get_moves.empty?
  end

  def can_move?(start_row, start_col, destination_row, destination_col)
    start_row, start_col = ChessBoardHelpers.conventional_coordinates_to_indices(start_row, start_col)
    destination_row, destination_col = ChessBoardHelpers.conventional_coordinates_to_indices(destination_row, destination_col)
    @board.can_move?(start_row, start_col, destination_row, destination_col, get_current_player)
  end

  def move(start_row, start_col, destination_row, destination_col)
    start_row, start_col = ChessBoardHelpers.conventional_coordinates_to_indices(start_row, start_col)
    destination_row, destination_col = ChessBoardHelpers.conventional_coordinates_to_indices(destination_row, destination_col)
    @board.move(start_row, start_col, destination_row, destination_col)
    @board.advance_turn
  end

  # Returns true iff the King of the given 'color' can castle with its rook on the
  # left or right, as given by the 'direction' parameter
  def can_castle?(direction, color = get_current_player)
    rook_col = direction == :left ? 0 : ChessBoardConstants::BOARD_DIMENSIONS - 1
    rook_row = color == :white ? 0 : ChessBoardConstants::BOARD_DIMENSIONS - 1
    rook = @board.get_piece(rook_row, rook_col)
    spaces_inbetween = []
    case direction
    when :left
      spaces_inbetween = [3, 2, 1]
    when :right
      spaces_inbetween = [5, 6]
    end
    is_empty_inbetween = spaces_inbetween.all? do |col|
      @board.get_piece(rook_row, col).is_blank_space?
    end
    spaces_crossed_by_king_are_safe = spaces_inbetween.take(2).all? do |col|
      not @kings[color].is_under_attack?(rook_row, col)
    end

    return (rook.get_type == :rook and rook.color == color and not rook.has_moved and not @kings[color].has_moved and
            is_empty_inbetween and spaces_crossed_by_king_are_safe and not @kings[color].is_under_attack?)
  end

  def castle(direction, color = get_current_player)
    rook_col = direction == :left ? 0 : ChessBoardConstants::BOARD_DIMENSIONS - 1
    rook_row = color == :white ? 0 : ChessBoardConstants::BOARD_DIMENSIONS - 1
    rook = @board.get_piece(rook_row, rook_col)
    king = @kings[color]
    king_direction = direction == :left ? -1 : 1

    @board.move(king.row, king.col, king.row, ChessBoardConstants::KING_COLUMN + 2 * king_direction)
    @board.move(rook.row, rook.col, rook.row, ChessBoardConstants::KING_COLUMN + king_direction)
    @board.advance_turn
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