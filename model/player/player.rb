require "contracts"
require_relative "../board"

class Player

    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants

    attr_reader :pattern_array, :piece

    invariant(@piece) {@piece == @original_piece}

    Contract String => Any
    def initialize(piece)
        @original_piece = piece
        @piece = @original_piece
    end

    Contract Board => nil
    def play(board_to_play)
        raise NotImplementedError, "Objects that extend Player must implement play."
    end
end
