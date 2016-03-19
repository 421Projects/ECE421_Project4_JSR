require_relative "../game_pieces/game_piece"
require_relative "../game_pattern"
require "contracts"

class GameMode

    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants    

    Contract None => Any
    def initialize()
        raise NotImplementedError, "Objects that extend GameMode must provide their own constructor."
    end

    Contract Nat => ArrayOf[HashOf[ArrayOf[Nat] => GamePiece]]
    def get_player_patterns(player_num)
        return player_patterns[player_num]
    end

    Contract Nat => GamePiece
    def get_player_piece(player_num)
        return player_pieces[player_num]
    end

end