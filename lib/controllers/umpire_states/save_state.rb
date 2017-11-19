require "controllers/umpire_states/umpire_state"

class SaveState < UmpireState
  def initialize(context, current_play_state)
    super(context)
    @current_play_state = current_play_state
  end

  def display_prompt_sign
    print "Enter a name for your game: "
  end

  def process_input(game_title)
    game_data = @current_play_state.get_game_data
    GameSaver.save_game(game_data.id, game_title, game_data)
    @context.set_state(@current_play_state)
    puts "Your game '#{game_title}' has been saved!"
  end
end