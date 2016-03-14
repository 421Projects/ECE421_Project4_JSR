require "./game_pattern"
require "./game_piece"
require 'contracts'

class Player

    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants

    invariant(@pattern) {@pattern == @original_pattern}
    invariant(@piece) {@piec == @original_piece}

    Contract GamePattern, GamePiece => Any
    def initialize(pattern, piece)
        @original_pattern = pattern
        @original_piece = piece
        @pattern = pattern
        @piece = piece
    end

    Contract None => nil
    def play()
        raise NotImplementedError, "Objects that extend Player must implement play."
    end
end
