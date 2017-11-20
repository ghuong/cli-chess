require "models/pieces/chess_piece"
require "models/chess_game"
require "utilities/constants"

# King game piece
class King < ChessPiece
include ChessPieceHelpers

  def get_type
    :king
  end

  def get_moves(ignore_allies = false, be_safe = true)
    [
      { row: @row + 1, col: @col },
      { row: @row - 1, col: @col },
      { row: @row, col: @col + 1 },
      { row: @row, col: @col - 1 },
      { row: @row + 1, col: @col + 1 },
      { row: @row + 1, col: @col - 1 },
      { row: @row - 1, col: @col + 1 },
      { row: @row - 1, col: @col - 1 },
    ].select do |move|
      allowed_destinations = [:blank_space, :enemy_piece]
      allowed_destinations << :ally_piece if ignore_allies
      allowed_destinations.include? describe_location(move[:row], move[:col]) and
        (not be_safe or not is_in_check?(move[:row], move[:col]))
    end
  end

  def is_in_check?(row = @row, col = @col)
    not get_pieces_which_can_move_to(row, col).empty?
  end

  # Get a list of all pieces of a given color which could hypothetically move to the given position,
  # ignoring the fact that pieces cannot capture their own color, and that 
  # Kings cannot put themselves in check
  def get_pieces_which_can_move_to(row, col)
    enemy_color = ChessGame.get_enemy_color(@color)
    @board.each_piece.select do |piece|
      piece.color == enemy_color and
        not piece.is_blank_space? and
        ((piece.get_type == :king and piece.get_moves(true, false).include?({ row: row, col: col })) or
          (piece.get_type != :king and piece.get_moves(true).include?({ row: row, col: col })))
    end
  end
end