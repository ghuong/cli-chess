require "utilities/chess_state_helpers"

class UmpireState
include ChessStateHelpers

  def initialize
    @should_display_long_prompt = true
    display_intro
  end

  # Display message prompting for input
  def display_prompt
    if @should_display_long_prompt
      display_long_prompt
      @should_display_long_prompt = false
    else
      display_short_prompt
    end
    display_prompt_sign
  end

  # Display intro message upon transitioning to state
  def display_intro; end
  # Display long-version of prompt
  def display_long_prompt; end
  # Display short-version of prompt
  def display_short_prompt
    display_long_prompt
  end
  def display_prompt_sign
    print " > "
  end
  # Process user input
  def process_input(context, command)
    ChessStateHelpers.display_invalid_command_warning
  end
end