require "models/pieces/chess_piece"

class EmptySpace < ChessPiece
  def get_type
    :empty
  end
end