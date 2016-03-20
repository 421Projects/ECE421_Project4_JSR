require "contracts"

class GameMode

    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants

    attr_accessor :pieces
    attr_accessor :patterns
    attr_accessor :board_width
    attr_accessor :board_height
    attr_accessor :num_players
    attr_reader :p1_piece
    attr_reader :p2_piece

    Contract None => Any
    def initialize()
        raise NotImplementedError, "Objects that extend GameMode must provide their own constructor."
    end

    Contract Player => ArrayOf[HashOf[[Nat, Nat], String]]
    def get_patterns(player)
        if @patterns[player] == nil
            raise NotImplementedError, "#{player} pattern not implemented."
        else
            return @patterns[player]
        end
    end

    Contract Player => String
    def get_piece_image(player)
        if @pieces[player] == nil
            raise NotImplementedError, "#{player} piece not implemented."
        else
            return @pieces[player]
        end
    end

end

