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

  # Returns the ChessPiece at the given coordinates
  # Raises error if coordinates invalid
  def get_piece(row, col)
    if not is_valid_coordinates?(row, col) then raise "Invalid coordinates" end
    
    @board[row][col]
  end

  # Sets the ChessPiece at the given coordinates
  # If no piece provided, sets to EmptySpace
  # Raises error if coordinates invalid
  def set_piece(row, col, piece = nil)
    if not is_valid_coordinates?(row, col) then raise "Invalid coordinates" end

    if piece.nil? then piece = EmptySpace.new end
    
    @board[row][col] = piece
    piece.row = row
    piece.col = col
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

  def is_valid_coordinates?(row, col)
    (0...Constants::BOARD_DIMENSIONS).cover?(row) and
    (0...Constants::BOARD_DIMENSIONS).cover?(col)
  end
end