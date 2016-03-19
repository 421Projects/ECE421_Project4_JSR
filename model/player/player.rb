require_relative "../game_pattern"
require_relative "../game_pieces/game_piece"
require_relative "../board"
require 'contracts'

class Player

    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants

    attr_reader :pattern_array, :piece

    invariant(@piece) {@piece == @original_piece}

    Contract ArrayOf[GamePattern], GamePiece => Any
    def initialize(piece)
        @original_piece = piece
        @piece = @original_piece
    end

    Contract Board => nil
    def play(board_to_play)
        raise NotImplementedError, "Objects that extend Player must implement play."
    end
end
