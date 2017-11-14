require "models/pieces/rook.rb"
require "models/chess_board.rb"

shared_examples "a rook" do
  let(:board) { ChessBoard.new }
  let(:subject) { described_class.new(board, :black) }

  describe '#get_moves' do
    context 'when placed at (0, 0)' do
      before { board.set_piece(0, 0, subject) }

      def correct_moves
        [
          { row: 0, col: 1 },
          { row: 0, col: 2 },
          { row: 0, col: 3 },
          { row: 0, col: 4 },
          { row: 0, col: 5 },
          { row: 0, col: 6 },
          { row: 0, col: 7 },

          { row: 1, col: 0 },
          { row: 2, col: 0 },
          { row: 3, col: 0 },
          { row: 4, col: 0 },
          { row: 5, col: 0 },
          { row: 6, col: 0 },
          { row: 7, col: 0 },
        ]
      end

      it 'returns fourteen correct moves' do
        expect(subject.get_moves).to include(*correct_moves)
      end
    end

    context 'when placed at (4, 4)' do
      before { board.set_piece(4, 4, subject) }

      def correct_moves
        [
          { row: 4, col: 0 },
          { row: 4, col: 1 },
          { row: 4, col: 2 },
          { row: 4, col: 3 },
          { row: 4, col: 5 },
          { row: 4, col: 6 },
          { row: 4, col: 7 },

          { row: 0, col: 4 },
          { row: 1, col: 4 },
          { row: 2, col: 4 },
          { row: 3, col: 4 },
          { row: 5, col: 4 },
          { row: 6, col: 4 },
          { row: 7, col: 4 },
        ]
      end

      it 'returns fourteen correct moves' do
        expect(subject.get_moves).to include(*correct_moves)
      end

      context 'with same color piece on (4, 3)' do
        before { board.set_piece(4, 3, Knight.new(board, :black)) }
        context 'with different color piece on (5, 4)' do
          before { board.set_piece(5, 4, Knight.new(board, :white)) }

          it 'cannot move to (4, 3) nor (4, 2)' do
            expect(subject.get_moves).not_to include({ row: 4, col: 3 })
            expect(subject.get_moves).not_to include({ row: 4, col: 2 })
          end

          it 'can move to (5, 4), but not (6, 4)' do
            expect(subject.get_moves).to include({ row: 5, col: 4 })
            expect(subject.get_moves).not_to include({ row: 6, col: 4 })
          end
        end
      end
    end
  end
end

describe Rook do
  it_behaves_like "a rook"

  context 'when at (0, 0)' do
    before { board.set_piece(0, 0, subject) }
    let(:board) { ChessBoard.new }
    subject { Rook.new(board, :black) }

    it 'has fourteen moves' do
      expect(subject.get_moves.length).to eql(14)
    end
  end
end