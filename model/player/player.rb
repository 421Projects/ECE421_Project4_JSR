require_relative "../game_pattern"
require_relative "../game_pieces/game_piece"

class Player

    def initialize(pattern, piece)
        @pattern = pattern
        @piece = piece
    end

    def play()
        raise NotImplementedError, "Objects that extend Player must implement play."
    end
end