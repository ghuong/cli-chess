require "utilities/chess_state_helpers"

# State Context (using the State pattern) for the chess game
class InteractiveChessStateContext
  def initialize
    set_state(IntroState.new(self))
  end

  # called only by the chess states
  def set_state(state)
    @state = state
  end

  # this is only for testing purposes
  def get_state
    @state
  end

  def display_prompt
    @state.display_prompt
  end

  def process_input(command)
    @state.process_input(command)
  end
end

class InteractiveChessState
include ChessStateHelpers

  def initialize(context)
    @context = context
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
  def process_input(command)
    ChessStateHelpers.display_invalid_command_warning
  end
end