require "yaml"

require "models/chess_board"

# Holds ALL state for the game
class ChessGameState
  attr_reader :id

  def initialize(id)
    @id = id
    @current_player = :white
    @board = ChessBoard.new
    @board.reset
  end

  def to_yaml
    YAML.dump(self)
  end

  def self.from_yaml(yaml)
    YAML.load(yaml)
  end
end