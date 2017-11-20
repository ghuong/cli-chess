require "models/chess_game"

describe ChessGame do

  let(:id) { 12 }
  subject { ChessGame.new(id) }

  context 'given id 12' do
    it 'has the given id' do
      expect(subject.id).to eql(id)
    end 
  end

  it 'has starting player :white' do
    expect(subject.current_player).to eql(:white)
  end

  describe '.get_enemy_color' do
    context 'given :white' do
      it 'returns :black' do
        expect(ChessGame.get_enemy_color(:white)).to eql(:black)
      end
    end

    context 'given :black' do
      it 'returns :white' do
        expect(ChessGame.get_enemy_color(:black)).to eql(:white)
      end
    end
  end

  describe '#switch_player' do
    context 'after calling' do
      before { subject.switch_player }
      it 'has current player :black' do
        expect(subject.current_player).to eql(:black)
      end
    end
  end

  describe '#checkmate?' do
    context 'upon initializing' do
      it 'returns false' do
        expect(subject.checkmate?(:black)).to be false
      end
    end

    context 'when white does 4-move checkmate' do
      before do
        subject.board.move(0, 3, 2, 5) # queen moves
        subject.board.move(0, 5, 6, 5) # bishop moves
      end

      it 'is checkmate' do
        expect(subject.checkmate?(:black)).to be true
      end
    end
  end
end