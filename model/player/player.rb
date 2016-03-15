require_relative "../game_pattern"
require_relative "../game_pieces/game_piece"
require 'contracts'

class Player

    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants

    invariant(@pattern_array) {@pattern == @original_pattern_array}
    invariant(@piece) {@piece == @original_piece}

    Contract ArrayOf[GamePattern], GamePiece => Any
    def initialize(pattern_array, piece)
        @original_pattern_array = pattern_array
        @original_piece = piece
        @pattern = @original_pattern_array
        @piece = @original_piece
    end

    Contract None => nil
    def play()
        raise NotImplementedError, "Objects that extend Player must implement play."
    end
end
