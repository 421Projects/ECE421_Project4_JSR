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

end

