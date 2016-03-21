require "contracts"
require "observer"
require_relative "../board"

class Player

    include Observable
    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants

    attr_reader :pattern_array, :piece, :name, :won

    invariant(@piece) {@piece == @original_piece}

    Contract String, ArrayOf[HashOf[[Nat, Nat], String]] => Any
    def initialize(piece, patterns, name=piece+":Player")
        @original_piece = piece
        @piece = @original_piece
        @name = name
        @pattern_array = patterns
        @won = false
    end

    Contract Bool => nil
    def won?(win_status)
        if win_status != @won
            puts "notified"
            changed
            notify_observers(self)
            @won = win_status
        end
        nil
    end

    def to_s
        return @name
    end

    def play(board_to_play)
        raise NotImplementedError, "Objects that extend Player must implement play."
    end
end
