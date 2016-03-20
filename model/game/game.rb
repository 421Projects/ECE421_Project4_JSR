require "contracts"
require_relative '../board'

class GameMode

    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants

    attr_accessor :pieces
    attr_accessor :patterns
    attr_accessor :board
    attr_accessor :board_width
    attr_accessor :board_height
    attr_accessor :num_players

    Contract None => Any
    def initialize()
        raise NotImplementedError, "Objects that extend GameMode must provide their own constructor."
    end

    def get_pattern(player)
        if patterns[player] == nil
            raise NotImplementedError, "#{player} pattern not implemented."
        else
            return patterns[player]
        end
    end

    def get_piece(player)
        if pieces[player] == nil
            raise NotImplementedError, "#{player} piece not implemented."
        else
            return pieces[player]
        end
    end
end

