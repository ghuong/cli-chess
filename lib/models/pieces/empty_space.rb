require "models/pieces/chess_piece"

class EmptySpace < ChessPiece
  def initialize
    super(nil, nil)
  end

  def get_type
    :empty
  end
end