require "models/pieces/pawn"
require "models/pieces/queen"
require "models/pieces/king"
require "models/pieces/bishop"
require "models/pieces/rook"
require "models/pieces/knight"

# Non-essential Helper methods mixed into ChessBoard
module ChessBoardHelpers
  # Reset the board with all pieces
  def reset
    # empty spaces
    (2..5).each do |row|
      (0...ChessBoardConstants::BOARD_DIMENSIONS).each do |col|
        set_piece(row, col)
      end
    end
    # pawns
    (0...ChessBoardConstants::BOARD_DIMENSIONS).each do |col|
      set_piece(Pawn.get_starting_row(:white), col, Pawn.new(self, :white))
      set_piece(Pawn.get_starting_row(:black), col, Pawn.new(self, :black))
    end

    white_row = 0
    black_row = ChessBoardConstants::BOARD_DIMENSIONS - 1
    # rooks
    [0, ChessBoardConstants::BOARD_DIMENSIONS - 1].each do |col|
      set_piece(white_row, col, Rook.new(self, :white))
      set_piece(black_row, col, Rook.new(self, :black))
    end
    # knights
    [1, ChessBoardConstants::BOARD_DIMENSIONS - 2].each do |col|
      set_piece(white_row, col, Knight.new(self, :white))
      set_piece(black_row, col, Knight.new(self, :black))
    end
    # bishops
    [2, ChessBoardConstants::BOARD_DIMENSIONS - 3].each do |col|
      set_piece(white_row, col, Bishop.new(self, :white))
      set_piece(black_row, col, Bishop.new(self, :black))
    end
    # queens
    set_piece(white_row, 3, Queen.new(self, :white))
    set_piece(black_row, 3, Queen.new(self, :black))
    # kings
    set_piece(white_row, 4, King.new(self, :white))
    set_piece(black_row, 4, King.new(self, :black))
  end

  # Moves the piece at (start_row, start_col) to (dest_row, dest_col)
  # This method provides no safeguards against invalid moves
  def move(start_row, start_col, dest_row, dest_col)
    piece = get_piece(start_row, start_col)
    set_piece(dest_row, dest_col, piece)
    set_piece(start_row, start_col)
  end

  # Returns true iff the piece at (start_row, start_col) can be moved
  # to (dest_row, dest_col) by the player of the given 'color'
  def can_move?(start_row, start_col, dest_row, dest_col, color)
    piece = get_piece(start_row, start_col)
    if piece.nil? or piece.is_blank_space? then return false end

    moves = piece.get_moves
    piece.color == color and
      moves.include?({ row: dest_row, col: dest_col })
  end

  def self.conventional_coordinates_to_indices(row, col)
    [row.to_i - 1, col.downcase.ord - "a".ord]
  end
end