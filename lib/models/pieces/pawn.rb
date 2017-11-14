require "models/pieces/chess_piece"

# Pawn chess piece
class Pawn < ChessPiece
  def get_type
    :pawn
  end

  def get_moves
    direction_sign = @color == :white ? 1 : -1
    starting_row = @color == :white ? 1 : ChessBoardConstants::BOARD_DIMENSIONS - 2

    forward_moves = [{ row: @row + (1 * direction_sign), col: @col }]
    if @row == starting_row
      forward_moves << { row: @row + (2 * direction_sign), col: @col }
    end

    forward_moves.select! do |move|
      :blank_space == describe_location(move[:row], move[:col])
    end

    attack_moves = [
      { row: @row + (1 * direction_sign), col: @col - 1 },
      { row: @row + (1 * direction_sign), col: @col + 1 }
    ].select do |move|
      :enemy_piece == describe_location(move[:row], move[:col])
    end

    return forward_moves + attack_moves
  end
end