require "contracts"

class Game

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
        raise NotImplementedError, "Objects that extend Game must provide their own constructor."
    end
    
    Contract Contracts::Nat,Contracts::Nat => Any
    def set_board_dimensions(board_width, board_height)
        @board_width = board_width
        @board_height = board_height
    end
    
    Contract None => String
    def title
        "Game"
    end
    
end
