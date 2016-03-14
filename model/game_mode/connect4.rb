require_relative "./game_mode"
require_relative "../game_pieces/black"
require_relative "../game_pieces/red"

class Connect4 < GameMode

    def initialize()
        @num_players = 2
        @player_pieces = []
        @player_patterns = []

        @player_pieces.push(BlackPiece.new)
        @player_pieces.push(RedPiece.new)

        # Create patterns for Black Pieces

        black_patterns = []
        pattern = Hash.new
        pattern[0, 0] = BlackPiece.new
        pattern[0, 1] = BlackPiece.new
        pattern[0, 2] = BlackPiece.new
        pattern[0, 3] = BlackPiece.new
        black_patterns << pattern

        pattern = Hash.new
        pattern[0, 0] = BlackPiece.new
        pattern[1, 0] = BlackPiece.new
        pattern[2, 0] = BlackPiece.new
        pattern[3, 0] = BlackPiece.new
        black_patterns << pattern

        pattern = Hash.new
        pattern[0, 0] = BlackPiece.new
        pattern[1, 1] = BlackPiece.new
        pattern[2, 2] = BlackPiece.new
        pattern[3, 3] = BlackPiece.new
        black_patterns << pattern

        pattern = Hash.new
        pattern[3, 0] = BlackPiece.new
        pattern[2, 1] = BlackPiece.new
        pattern[1, 2] = BlackPiece.new
        pattern[0, 3] = BlackPiece.new
        black_patterns << pattern

        @player_patterns << black_patterns


        red_patterns = []
        pattern = Hash.new
        pattern[0, 0] = RedPiece.new
        pattern[0, 1] = RedPiece.new
        pattern[0, 2] = RedPiece.new
        pattern[0, 3] = RedPiece.new
        red_patterns << pattern

        pattern = Hash.new
        pattern[0, 0] = RedPiece.new
        pattern[1, 0] = RedPiece.new
        pattern[2, 0] = RedPiece.new
        pattern[3, 0] = RedPiece.new
        red_patterns << pattern

        pattern = Hash.new
        pattern[0, 0] = RedPiece.new
        pattern[1, 1] = RedPiece.new
        pattern[2, 2] = RedPiece.new
        pattern[3, 3] = RedPiece.new
        red_patterns << pattern

        pattern = Hash.new
        pattern[3, 0] = RedPiece.new
        pattern[2, 1] = RedPiece.new
        pattern[1, 2] = RedPiece.new
        pattern[0, 3] = RedPiece.new
        red_patterns << pattern
        
        player_patterns << red_patterns
    end
end