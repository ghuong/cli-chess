require "models/chess_game_state"

describe ChessGameState do

  let(:id) { 12 }
  subject { ChessGameState.new(id) }

  context 'given id 12' do
    it 'has the given id' do
      expect(subject.id).to eql(id)
    end 
  end
end