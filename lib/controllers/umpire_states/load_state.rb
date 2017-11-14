require "controllers/umpire_states/interactive_chess_state"

class LoadState < InteractiveChessState
  def display_long_prompt
    puts "Saved games:"
    saved_games = GameSaver.get_list_of_saved_games
    saved_games.each do |game|
      puts " -- #{game[:id]}: #{game[:title]}"
    end
  end

  def display_prompt_sign
    print "Type game ID (or 'back' to return): "
  end

  def process_input(command)
    case command
    when "back"
      @context.set_state(IntroState.new(@context))
    else
      id = command.to_i
      game_data = GameSaver.load_game_by_id(id)
      if not game_data.nil?
        @context.set_state(PlayState.new(@context, game_data))
      else
        puts "Sorry, '#{command}' is not a valid game ID."
      end
    end
  end
end