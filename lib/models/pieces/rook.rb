require "models/pieces/chess_piece"
require "utilities/constants"

# Rook game piece
class Rook < ChessPiece
include ChessPieceHelpers

  def get_type
    :rook
  end

  def get_moves(ignore_allies = false)
    get_straight_moves(ignore_allies)
  end
end