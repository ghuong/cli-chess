require "models/chess_game_state"

describe ChessGameState do

  let(:id) { 12 }
  let(:dump_and_load) { ChessGameState.from_yaml(subject.to_yaml) }
  subject { ChessGameState.new(id) }

  context 'given id 12' do
    it 'has the given id' do
      expect(subject.id).to eql(id)
    end

    it 'has same id after YAML dump/load' do
      expect(dump_and_load.id).to eql(id)
    end  
  end
end