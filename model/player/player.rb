require "contracts"
require_relative "../board"

class Player

    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants

    attr_reader :pattern_array
    attr_accessor :piece

    Contract String => Any
    def initialize(piece)
        @piece = piece
    end

    Contract Board => nil
    def play(board_to_play)
        raise NotImplementedError, "Objects that extend Player must implement play."
    end
end
