# Non-essential Helper methods mixed into ChessBoard
module ChessBoardHelpers
  # Reset the board with all pieces
  def reset
    (2..5).each do |row|
      (0...ChessBoardConstants::BOARD_DIMENSIONS).each do |col|
        set_piece(row, col)
      end
    end
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