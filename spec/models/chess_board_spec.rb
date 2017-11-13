require "models/chess_board"
require "models/pieces/knight.rb"

describe ChessBoard do

  context 'when empty' do
    def is_filled_with_empty?(test_obj)
      (0...8).each do |row|
        (0...8).each do |col|
          expect(test_obj.get_piece(row, col).is_blank_space?).to be true
        end
      end
    end

    it 'is filled with empty pieces' do
      is_filled_with_empty?(subject)
    end

    describe '#set_piece' do
      context 'after putting Knight at (3, 4)' do
        let(:row) { 3 }
        let(:col) { 4 }
        before { subject.set_piece(row, col, Knight.new(subject, :black)) }

        it 'has a Knight there' do
          expect(subject.get_piece(row, col).get_type).to eql(:knight)
        end

        context 'after removing that Knight' do
          before { subject.set_piece(row, col) }

          it 'has no Knight anymore' do
            expect(subject.get_piece(row, col).is_blank_space?).to be true
          end
        end
      end
    end
  end
end