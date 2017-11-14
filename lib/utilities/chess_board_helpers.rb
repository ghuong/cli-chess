require "models/pieces/pawn"

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
      set_piece(Pawn.get_starting_row(:white), col, Pawn.new(@board, :white))
      set_piece(Pawn.get_starting_row(:black), col, Pawn.new(@board, :black))
    end

    white_row = 0
    black_row = ChessBoardConstants::BOARD_DIMENSIONS - 1
    # rooks
    [0, ChessBoardConstants::BOARD_DIMENSIONS - 1].each do |col|
      set_piece(white_row, col, Rook.new(@board, :white))
      set_piece(black_row, col, Rook.new(@board, :black))
    end
    # knights
    [1, ChessBoardConstants::BOARD_DIMENSIONS - 2].each do |col|
      set_piece(white_row, col, Knight.new(@board, :white))
      set_piece(black_row, col, Knight.new(@board, :black))
    end
    # bishops
    [2, ChessBoardConstants::BOARD_DIMENSIONS - 3].each do |col|
      set_piece(white_row, col, Bishop.new(@board, :white))
      set_piece(black_row, col, Bishop.new(@board, :black))
    end
    # queens
    set_piece(white_row, 3, Queen.new(@board, :white))
    set_piece(black_row, 3, Queen.new(@board, :black))
    # kings
    set_piece(white_row, 4, King.new(@board, :white))
    set_piece(black_row, 4, King.new(@board, :black))
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
    if piece.is_blank_space? then return false end

    moves = piece.get_moves
    piece.color == color and
      moves.include?({ row: dest_row, col: dest_col })
  end
end