require "models/pieces/chess_piece"

class Knight < ChessPiece
  def get_type
    :knight
  end

  def get_moves
    moves = [
      { row: @row + 1, col: @col + 2 },
      { row: @row + 1, col: @col - 2 },
      { row: @row + 2, col: @col + 1 },
      { row: @row + 2, col: @col - 1 },
      { row: @row - 1, col: @col + 2 },
      { row: @row - 1, col: @col - 2 },
      { row: @row - 2, col: @col + 1 },
      { row: @row - 2, col: @col - 1 }
    ].select do |move|
      @board.is_valid_coordinates?(move[:row], move[:col])
    end
  end
end