# Defines a chess piece; note that "empty spaces" are also pieces
# This class should not be instantiated directly
class ChessPiece
  attr_accessor :row, :col, :board
  attr_reader :color

  def initialize(board, color)
    @board = board
    @color = color
  end

  # Return the symbol representing the class
  def get_type; raise NotImplementedError end

  # Return an array of legal moves
  # "Legal" means "not off the board"
  def get_moves; raise NotImplementedError end

  def describe_location(row, col)
    if not @board.is_valid_coordinates?(row, col)
      return :off_board
    else
      piece = @board.get_piece(row, col)
      if piece.is_blank_space?
        :blank_space
      elsif piece.color == @color
        :ally_piece
      else
        :enemy_piece
      end
    end
  end

  # Returns true iff this "piece" represents an empty space on the ChessBoard
  def is_blank_space?
    get_type == :empty
  end
end

# Non-essential helper methods for Chess Pieces
module ChessPieceHelpers
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