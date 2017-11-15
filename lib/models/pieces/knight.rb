require "models/pieces/chess_piece"

# Knight chess piece
class Knight < ChessPiece
  def get_type
    :knight
  end

  # The Knight can move in a L-shape, within the board,
  # and never attacking an allied piece
  def get_moves(ignore_allies = false)
    [
      { row: @row + 1, col: @col + 2 },
      { row: @row + 1, col: @col - 2 },
      { row: @row + 2, col: @col + 1 },
      { row: @row + 2, col: @col - 1 },
      { row: @row - 1, col: @col + 2 },
      { row: @row - 1, col: @col - 2 },
      { row: @row - 2, col: @col + 1 },
      { row: @row - 2, col: @col - 1 }
    ].select do |move|
      allowed_destinations = [:blank_space, :enemy_piece]
      allowed_destinations << :ally_piece if ignore_allies
      allowed_destinations.include? describe_location(move[:row], move[:col])
    end
  end
end