require_relative "../model/board"
require_relative "../model/player/ai_player"
require_relative "../model/player/real_player"
require_relative "../model/game_pieces/game_piece"
require_relative "../model/game_pattern"

class GameController

    def initialize()
        @players = []
    end

    def place_piece(piece, position)
    end

    def create_real_players(num_players)
        for i in 0..num_players - 1
            @players.push(new RealPlayer())
        end
    end

    def create_ai_players(num_players)

    end

    def get_number_of_players()
        return @players.length
    end

    def modify_player
    end

    def modify_game_piece
    end

    def modify_game_pattern
    end

end

