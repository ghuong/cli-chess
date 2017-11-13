require "constants/chess_board_constants"
require "models/pieces/empty_space"

# Barebones container supporting Marshal serialization
class ChessBoard
  attr_reader :id

  def initialize(id, board = nil)
    @id = id
    @board = board
    if @board.nil?
      @board = []
      Constants::BOARD_DIMENSIONS.times do |row|
        @board << [EmptySpace.new] * Constants::BOARD_DIMENSIONS
      end
    end
  end

  def get_piece(row, col)
    if not is_valid_coordinates?(row, col) then raise "Invalid coordinates" end
    
    @board[row][col]
  end

  def set_piece(row, col, piece = nil)
    if not is_valid_coordinates?(row, col) then raise "Invalid coordinates" end

    if piece.nil? then piece = EmptySpace.new end
    @board[row][col] = piece
  end

  def marshal_dump
    Marshal.dump({
      id: @id, board: @board  
    })
  end

  def self.marshal_load(marshalled)
    data = Marshal.load(marshalled)
    self.new(data[:id], data[:board])
  end

private

  def is_valid_coordinates?(row, col)
    (0...Constants::BOARD_DIMENSIONS).cover?(row) and
    (0...Constants::BOARD_DIMENSIONS).cover?(col)
  end
end