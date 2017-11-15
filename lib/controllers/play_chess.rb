$: << "lib"

require "controllers/umpire_states/interactive_chess_state_context"

def main
  game_context = InteractiveChessStateContext.new
  loop do
    game_context.display_prompt
    input = gets.chomp.downcase
    puts
    result = game_context.process_input(input)
    case result
    when "quit"
      break
    when "white"
      "Checkmate! White wins!"
      break
    when "black"
      "Checkmate! Black wins!"
      break
    end
  end

  puts
  puts "Thanks for playing!"
end

main