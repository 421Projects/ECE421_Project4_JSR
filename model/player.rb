require "./game_pattern"
require "./game_piece"

class Player

    def initialize(pattern, piece)
        @pattern = pattern
        @piece = piece
    end

    def play()
        raise NotImplementedError, "Objects that extend Player must implement play."
    end
end