require "utilities/game_saver"
require "models/chess_game_state"

# Helper methods to be mixed into the chess states
module ChessStateHelpers
  def self.get_new_game
    id = GameSaver.get_unique_id
    ChessGameState.new(id)
  end

  def self.is_there_no_saved_games?
    GameSaver.get_list_of_saved_games.empty?
  end

  def self.display_invalid_command_warning
    puts "Sorry, I do not understand your input."
  end
end