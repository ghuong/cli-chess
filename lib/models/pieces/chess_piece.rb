# Defines a chess piece; note that "empty spaces" are also pieces
# This class should not be instantiated directly
class ChessPiece
  attr_accessor :row, :col
  attr_reader :color, :board

  def initialize(board = nil, color = nil)
    @board = board
    @color = color
  end

  # Return the symbol representing the class
  def get_type; raise NotImplementedError end

  # Return an array of legal moves
  # "Legal" means "not off the board"
  def get_moves; raise NotImplementedError end

  # Returns true iff this "piece" represents an empty space on the ChessBoard
  def is_blank_space?
    get_type == :empty
  end
end