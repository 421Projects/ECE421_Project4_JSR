require "contracts"

class GameMode

    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants

    attr_accessor :patterns
    attr_accessor :board_width
    attr_accessor :board_height
    attr_reader :p1_piece
    attr_reader :p2_piece
    attr_reader :p1_patterns
    attr_reader :p2_patterns
    attr_reader :num_of_players
    attr_reader :pieces, :patterns

    Contract None => Any
    def initialize()
        raise NotImplementedError, "Objects that extend GameMode must provide their own constructor."
    end

    Contract None => Bool
    def ai_compatible?
        return true
    end

end
