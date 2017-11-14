require "models/pieces/queen"
require "models/pieces/rook_spec"
require "models/pieces/bishop_spec"

describe Queen do
  it_behaves_like "a rook"
  it_behaves_like "a bishop"
end