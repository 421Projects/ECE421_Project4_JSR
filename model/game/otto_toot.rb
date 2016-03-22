require_relative "./game"

class OttoToot < GameMode

    def initialize()
        @num_of_players = 2
        @p1_piece = "O"
        @p2_piece = "T"

        @board_width = 7
        @board_height = 6

        # This will hold the images related to each piece:
        # String => Image

        # @patterns = {
        #     p1 => [
        #         {

        #         }
        #     ]
        # }

        # Create patterns for Black Pieces

        @p1_patterns = []
        pattern = {}
        pattern[[0, 0]] = @p1_piece
        pattern[[0, 1]] = @p2_piece
        pattern[[0, 2]] = @p2_piece
        pattern[[0, 3]] = @p1_piece
        @p1_patterns << pattern

        pattern = {}
        pattern[[0, 0]] = @p1_piece
        pattern[[1, 0]] = @p2_piece
        pattern[[2, 0]] = @p2_piece
        pattern[[3, 0]] = @p1_piece
        @p1_patterns << pattern

        pattern = {}
        pattern[[0, 0]] = @p1_piece
        pattern[[1, 1]] = @p2_piece
        pattern[[2, 2]] = @p2_piece
        pattern[[3, 3]] = @p1_piece
        @p1_patterns << pattern

        pattern = {}
        pattern[[3, 0]] = @p1_piece
        pattern[[2, 1]] = @p2_piece
        pattern[[1, 2]] = @p2_piece
        pattern[[0, 3]] = @p1_piece
        @p1_patterns << pattern

        @p2_patterns = []
        pattern = {}
        pattern[[0, 0]] = @p2_piece
        pattern[[0, 1]] = @p1_piece
        pattern[[0, 2]] = @p1_piece
        pattern[[0, 3]] = @p2_piece
        @p2_patterns << pattern

        pattern = {}
        pattern[[0, 0]] = @p2_piece
        pattern[[1, 0]] = @p1_piece
        pattern[[2, 0]] = @p1_piece
        pattern[[3, 0]] = @p2_piece
        @p2_patterns << pattern

        pattern = {}
        pattern[[0, 0]] = @p2_piece
        pattern[[1, 1]] = @p1_piece
        pattern[[2, 2]] = @p1_piece
        pattern[[3, 3]] = @p2_piece
        @p2_patterns << pattern

        pattern = {}
        pattern[[3, 0]] = @p2_piece
        pattern[[2, 1]] = @p1_piece
        pattern[[1, 2]] = @p1_piece
        pattern[[0, 3]] = @p2_piece
        @p2_patterns << pattern

    end
    
end
