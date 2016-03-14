require_relative "./game_pieces/game_piece"
require 'contracts'

class GamePattern

    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants

    invariant(@pattern) {@pattern == @original_pattern_array}

    Contract ArrayOf[ArrayOf[GamePiece]] => Any
    def initialize(pattern_array)
        @original_pattern_array = pattern_array
        @pattern = pattern_array
    end
end
