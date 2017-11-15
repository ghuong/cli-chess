require "models/pieces/chess_piece"
require "utilities/constants"

# Queen game piece
class Queen < ChessPiece
include ChessPieceHelpers

  def get_type
    :queen
  end

  def get_moves(ignore_allies = false)
    get_straight_moves(ignore_allies) + get_diagonal_moves(ignore_allies)
  end
end