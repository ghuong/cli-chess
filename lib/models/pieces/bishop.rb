require "models/pieces/chess_piece"
require "utilities/constants"

# Bishop game piece
class Bishop < ChessPiece
include ChessPieceHelpers

  def get_type
    :bishop
  end

  # Bishop can move any number of spaces diagonally,
  # but cannot jump over other pieces
  def get_moves
    northwest_moves = []
    northeast_moves = []
    southwest_moves = []
    southeast_moves = []
    (1...ChessBoardConstants::BOARD_DIMENSIONS).each do |step|
      northwest_moves << { row: @row + step, col: @col - step }
      northeast_moves << { row: @row + step, col: @col + step }
      southwest_moves << { row: @row - step, col: @col - step }
      southeast_moves << { row: @row - step, col: @col + step }
    end
    return select_legal_moves(northwest_moves) +
           select_legal_moves(northeast_moves) +
           select_legal_moves(southwest_moves) +
           select_legal_moves(southeast_moves)
  end
end