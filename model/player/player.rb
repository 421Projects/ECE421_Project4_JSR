require_relative "../game_pattern"
require_relative "../game_pieces/game_piece"
require 'contracts'

class Player

    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants

    invariant(@pattern) {@pattern == @original_pattern}
    invariant(@piece) {@piece == @original_piece}

    Contract GamePattern, GamePiece => Any
    def initialize(pattern, piece)
        @original_pattern = pattern
        @original_piece = piece
        @pattern = @original_pattern
        @piece = @original_piece
    end

    Contract None => nil
    def play()
        raise NotImplementedError, "Objects that extend Player must implement play."
    end
end
