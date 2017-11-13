require "models/pieces/chess_piece"

class EmptySpace < ChessPiece
  def initialize
  end

  def get_type
    :empty
  end
end