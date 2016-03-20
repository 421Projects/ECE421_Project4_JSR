<<<<<<< HEAD
=======
require "contracts"
>>>>>>> 7ba36778f256d3f995cd9c1ed0b2799601926d27
require_relative "../board"

class Player

    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants

    attr_reader :pattern_array, :piece, :name

    invariant(@piece) {@piece == @original_piece}

    Contract Any => Any
    def initialize(piece, name=piece+":Player")
        @original_piece = piece
        @piece = @original_piece
        @name = name
    end

    def to_s
        return @name
    end

    Contract Any => nil
    def play(board_to_play)
        raise NotImplementedError, "Objects that extend Player must implement play."
    end
end
