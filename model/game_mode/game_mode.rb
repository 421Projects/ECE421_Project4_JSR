require_relative "../game_pieces/game_piece"
require_relative "../game_pattern"

class GameMode

    def initialize()
        @num_players = nil
        @player_pieces = []
        @player_patterns = []
    end

    def get_player_patterns(player_num)
        return player_patterns[player_num]
    end

    def get_player_piece(player_num)
        return player_pieces[player_num]
    end

end