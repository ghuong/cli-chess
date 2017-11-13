# Defines a chess piece; note that "empty spaces" are also pieces
class ChessPiece
  def initialize; raise NotImplementedError end

  # Return the symbol appropriate to the class
  def get_type; raise NotImplementedError end

  def is_blank_space?
    get_type == :empty
  end
end