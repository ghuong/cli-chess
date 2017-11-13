require "models/pieces/chess_piece"
require "utilities/constants"

# Bishop game piece
class Bishop < ChessPiece
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

private

  # Loop through the given array 'moves', upon reaching
  # a non-blank space, remove all subsequent moves
  def select_legal_moves(moves)
    legal_moves = []
    moves.each do |move|
      description = describe_location(move[:row], move[:col])
      
      if [:blank_space, :enemy_piece].include? description
        legal_moves << move
      end

      break if description != :blank_space
    end
    return legal_moves
  end
end