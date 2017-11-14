require "controllers/interactive_chess_state"

def main
  loop do
    game_context = InteractiveChessStateContext.new
    loop do
      game_context.display_output
      input = gets.chomp.downcase
      result = game_context.process_input(input)
     break if result == "quit"
    end

    puts
    puts "Thanks for playing!"
end

main