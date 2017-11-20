require "models/chess_board"

# Defines a chess piece; note that "empty spaces" are also pieces
# This class should not be instantiated directly
class ChessPiece
  attr_accessor :row, :col, :board, :has_moved
  attr_reader :color

  def initialize(board, color)
    @board = board
    @color = color
    @has_moved = false
  end

  # Return the symbol representing the class
  def get_type; raise NotImplementedError end

  # Return an array of legal moves
  # if ignore_allies flag is set to true, then assume that all
  # allied pieces are enemy pieces
  def get_moves(ignore_allies = false); raise NotImplementedError end

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
  # Return all legal moves, if moving straight
  def get_straight_moves(ignore_allies = false)
    north_moves = []
    south_moves = []
    west_moves = []
    east_moves = []
    (1...ChessBoardConstants::BOARD_DIMENSIONS).each do |step|
      north_moves << { row: @row + step, col: @col }
      south_moves << { row: @row - step, col: @col }
      west_moves << { row: @row, col: @col - step }
      east_moves << { row: @row, col: @col + step }
    end
    return select_legal_moves(north_moves, ignore_allies) +
           select_legal_moves(south_moves, ignore_allies) +
           select_legal_moves(west_moves, ignore_allies) +
           select_legal_moves(east_moves, ignore_allies)
  end

  # Return all legals moves, if moving diagonally
  def get_diagonal_moves(ignore_allies = false)
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
    return select_legal_moves(northwest_moves, ignore_allies) +
           select_legal_moves(northeast_moves, ignore_allies) +
           select_legal_moves(southwest_moves, ignore_allies) +
           select_legal_moves(southeast_moves, ignore_allies)
  end

  # Loop through the given array 'moves', upon reaching
  # any piece, remove all subsequent moves
  def select_legal_moves(moves, ignore_allies = false)
    legal_moves = []
    moves.each do |move|
      description = describe_location(move[:row], move[:col])
      
      allowed_destinations = [:blank_space, :enemy_piece]
      allowed_destinations << :ally_piece if ignore_allies
      if allowed_destinations.include? description
        legal_moves << move
      end

      break if description != :blank_space
    end
    return legal_moves
  end
end