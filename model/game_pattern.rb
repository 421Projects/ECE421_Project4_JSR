require_relative "./game_pieces/game_piece"
require 'contracts'

class GamePattern

    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants

    attr_accessor :pattern


    Contract HashOf[ArrayOf[Contracts::Nat] => GamePiece] => Any
    def initialize
        @original_pattern = {}
        @pattern = {}
    end

    def []=(location, piece)
        @pattern[location] = piece
    end
end
