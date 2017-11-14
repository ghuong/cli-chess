require "models/pieces/chess_piece"
require "utilities/constants"

# Rook game piece
class Rook < ChessPiece
include ChessPieceHelpers

  def get_type
    :rook
  end

  def get_moves
    north_moves = []
    south_moves = []
    west_moves = []
    east_moves = []
    (1...ChessBoardConstants::BOARD_DIMENSIONS).each do |step|
      north_moves << { row: @row + step, col: @col }
      south_moves << { row: @row - step, col: @col }
      west_moves << { row: @row, col: @col - step }
      east_moves << { row: @row, col: @col + step }
    end
    return select_legal_moves(north_moves) +
           select_legal_moves(south_moves) +
           select_legal_moves(west_moves) +
           select_legal_moves(east_moves)
  end
end