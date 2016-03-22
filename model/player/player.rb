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

    Contract String, ArrayOf[HashOf[[Nat, Nat], String]], Maybe[String] => Any
    def initialize(piece, patterns, name=piece+":Player")
        @original_piece = piece
        @piece = @original_piece
        @name = name
        @pattern_array = patterns
        @won = false
        nil
    end

    Contract Bool => nil
    def set_win_status(win_status)
        if win_status != @won
            changed
            notify_observers(self)
            @won = win_status
        end
        nil
    end

    Contract None => String
    def to_s
        return @name
    end

    #Contract Board => Any
    def play(board_to_play)
        raise NotImplementedError, "Objects that extend Player must implement play."
    end
end
