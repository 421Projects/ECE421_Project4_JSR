require_relative "./game"

class OttoToot < GameMode
    invariant(@num_players) {@num_players == @og_num_players}
    invariant(@player_pieces) {@player_pieces == @og_player_pieces}
    invariant(@player_patterns) {@player_patterns == @og_player_patterns}
    
end