require "controllers/umpire_states/intro_state"

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