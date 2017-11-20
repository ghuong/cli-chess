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

  describe '#can_castle?' do
    def expect_can_castle(can_castle = true)
      expect(subject.can_castle?(color, direction)).to be can_castle
    end

    context 'given color black' do
      let(:color) { :black }
      let(:king) { subject.board.get_piece(7, 4) }

      context 'given direction right' do
        let(:direction) { :right }
        let(:rook) { subject.board.get_piece(7, 7) }

        context 'when there are no pieces in-between' do
          before do
            subject.board.set_piece(7, 5)
            subject.board.set_piece(7, 6)
          end

          context 'when rook has moved' do
            before { rook.has_moved = true }
            it 'returns false' do
              expect_can_castle(false)
            end
          end

          context 'when king has moved' do
            before { king.has_moved = true }
            it 'returns false' do
              expect_can_castle(false)
            end
          end

          context 'when neither king nor rook have moved' do
            context 'when king is not in check' do
              it 'returns true' do
                expect_can_castle
              end
            end
          end
        end

        context 'when there is one piece in-between' do
          before { subject.board.set_piece(7, 5) }
          context 'when neither king nor rook have moved' do
            it 'returns false' do
              expect_can_castle(false)
            end
          end
        end
      end

      context 'given direction left' do
        let(:direction) { :left }
        let(:rook) { subject.board.get_piece(7, 0) }

        context 'when neither king nor rook have moved' do
          context 'when there are no pieces in-between' do
            before do
              subject.board.set_piece(7, 1)
              subject.board.set_piece(7, 2)
              subject.board.set_piece(7, 3)
            end
            context 'when king is not in check' do
              it 'returns true' do
                expect_can_castle
              end
            end

            context 'when king is in check' do
              before { subject.board.set_piece(6, 3, Pawn.new(subject.board, :white)) }
              it 'returns false' do
                expect_can_castle(false)
              end
            end
          end

          context 'when there is one piece in-between' do
            before do
              subject.board.set_piece(7, 1)
              subject.board.set_piece(7, 2)
            end

            it 'returns false' do
              expect_can_castle(false)
            end
          end
        end
      end
    end
  end
end