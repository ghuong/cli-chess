require "models/pieces/bishop.rb"
require "models/chess_board.rb"

shared_examples "a bishop" do

  let(:board) { ChessBoard.new }
  let(:subject) { described_class.new(board, :black) }

  describe '#get_moves' do
    context 'when placed at (0, 0)' do
      before { board.set_piece(0, 0, subject) }

      def correct_moves
        [
          { row: 1, col: 1 },
          { row: 2, col: 2 },
          { row: 3, col: 3 },
          { row: 4, col: 4 },
          { row: 5, col: 5 },
          { row: 6, col: 6 },
          { row: 7, col: 7 }
        ]
      end

      it 'returns seven correct moves' do
        expect(subject.get_moves).to include(*correct_moves)
      end
    end

    context 'when placed at (4, 4)' do
      before { board.set_piece(4, 4, subject) }

      def correct_moves
        [
          { row: 0, col: 0 },
          { row: 1, col: 1 },
          { row: 2, col: 2 },
          { row: 3, col: 3 },
          { row: 5, col: 5 },
          { row: 6, col: 6 },
          { row: 7, col: 7 },

          { row: 3, col: 5 },
          { row: 2, col: 6 },
          { row: 1, col: 7 },

          { row: 5, col: 3 },
          { row: 6, col: 2 },
          { row: 7, col: 1 },
        ]
      end

      it 'returns thirteen correct moves' do
        expect(subject.get_moves).to include(*correct_moves)
      end

      context 'with same color piece on (6, 6)' do
        before { board.set_piece(6, 6, Knight.new(board, :black)) }
        context 'with different color piece on (2, 2)' do
          before { board.set_piece(2, 2, Knight.new(board, :white)) }

          it 'cannot move to (6, 6) nor (7, 7)' do
            expect(subject.get_moves).not_to include({ row: 6, col: 6 })
            expect(subject.get_moves).not_to include({ row: 7, col: 7 })
          end

          it 'can move to (2, 2), but not (1, 1)' do
            expect(subject.get_moves).to include({ row: 2, col: 2 })
            expect(subject.get_moves).not_to include({ row: 1, col: 1 })
          end
        end
      end
    end
  end
end

describe Bishop do
  it_behaves_like "a bishop"

  context 'when at (0, 0)' do
    before { board.set_piece(0, 0, subject) }
    let(:board) { ChessBoard.new }
    subject { Bishop.new(board, :black) }

    it 'has seven moves' do
      expect(subject.get_moves.length).to eql(7)
    end
  end
end