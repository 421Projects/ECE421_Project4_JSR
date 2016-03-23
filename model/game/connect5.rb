require_relative "./game"

class Connect5_4P < Game

    def initialize()
        @num_of_players = 4
        @p1_piece = "B"
        @p2_piece = "R"
        @p3_piece = "G"
        @p4_piece = "P"
        @p1_image = "../../assets/Tile_Black.png"
        @p2_image = "../../assets/Tile_Red.png"
        @p3_image = "../../assets/Tile_Green.png"
        @p4_image = "../../assets/Tile_Pink.png"
        @pieces = [@p1_piece, @p2_piece, @p3_piece, @p4_piece]
        @board_width = 10
        @board_height = 10

        # Create patterns for Black Pieces
        @p1_patterns = []
        @p2_patterns = []
        @p3_patterns = []
        @p4_patterns = []
        @patterns = []
        @patterns = [
            @p1_patterns,
            @p2_patterns,
            @p3_patterns,
            @p4_patterns
        ]

        # http://stackoverflow.com/questions/3580049/whats-the-ruby-way-to-iterate-over-two-arrays-at-once
        @pieces.zip(@patterns).each do |piece, pattern|
            pattern_const = {}
            pattern_const[[0, 0]] = piece
            pattern_const[[0, 1]] = piece
            pattern_const[[0, 2]] = piece
            pattern_const[[0, 3]] = piece
            pattern_const[[0, 4]] = piece
            pattern << pattern_const

            pattern_const = {}
            pattern_const[[0, 0]] = piece
            pattern_const[[1, 0]] = piece
            pattern_const[[2, 0]] = piece
            pattern_const[[3, 0]] = piece
            pattern_const[[4, 0]] = piece
            pattern << pattern_const

            pattern_const = {}
            pattern_const[[0, 0]] = piece
            pattern_const[[1, 1]] = piece
            pattern_const[[2, 2]] = piece
            pattern_const[[3, 3]] = piece
            pattern_const[[4, 4]] = piece
            pattern << pattern_const

            pattern_const = {}
            pattern_const[[4, 0]] = piece
            pattern_const[[3, 1]] = piece
            pattern_const[[2, 2]] = piece
            pattern_const[[1, 3]] = piece
            pattern_const[[0, 4]] = piece
            pattern << pattern_const
        end
    end
    
    def title
        "Connect 5"
    end
end
