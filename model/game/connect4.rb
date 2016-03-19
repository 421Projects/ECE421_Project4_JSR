require_relative "./game"

class Connect4 < GameMode

    attr_accessor :p1, :p2

    invariant(@num_players) {@num_players == @og_num_players}

    def initialize(p1 = nil, p2 = nil)
        @p1_piece = "B"
        @p2_piece = "R"
        case p1
        when nil
            @p1 = real_player.new(@p1_piece)
        when Player
            @p1 = p1
        end

        case p2
        when nil
            @p2 = real_player.new(@p2_piece)
        when Player
            @p2 = p2
        end

        setup_game_config()
    end

    def setup_game_config
        @num_players = 2
        @og_num_players = @num_players
        @board_width = 7
        @board_height = 6


        # This will hold the images related to each piece:
        # String => Image
        @pieces = {}


        # @patterns = {
        #     p1 => [
        #         {

        #         }
        #     ]
        # }


        # Create patterns for Black Pieces
        # Stored as [row, column]
        black_patterns = []
        pattern = {}
        pattern[[0, 0]] = @p1
        pattern[[0, 1]] = @p1
        pattern[[0, 2]] = @p1
        pattern[[0, 3]] = @p1
        black_patterns << pattern

        pattern = {}
        pattern[[0, 0]] = @p1
        pattern[[1, 0]] = @p1
        pattern[[2, 0]] = @p1
        pattern[[3, 0]] = @p1
        black_patterns << pattern

        pattern = {}
        pattern[[0, 0]] = @p1
        pattern[[1, 1]] = @p1
        pattern[[2, 2]] = @p1
        pattern[[3, 3]] = @p1
        black_patterns << pattern

        pattern = {}
        pattern[[3, 0]] = @p1
        pattern[[2, 1]] = @p1
        pattern[[1, 2]] = @p1
        pattern[[0, 3]] = @p1
        black_patterns << pattern

        red_patterns = []
        pattern = {}
        pattern[[0, 0]] = @p2
        pattern[[0, 1]] = @p2
        pattern[[0, 2]] = @p2
        pattern[[0, 3]] = @p2
        red_patterns << pattern

        pattern = {}
        pattern[[0, 0]] = @p2
        pattern[[1, 0]] = @p2
        pattern[[2, 0]] = @p2
        pattern[[3, 0]] = @p2
        red_patterns << pattern

        pattern = {}
        pattern[[0, 0]] = @p2
        pattern[[1, 1]] = @p2
        pattern[[2, 2]] = @p2
        pattern[[3, 3]] = @p2
        red_patterns << pattern

        pattern = {}
        pattern[[3, 0]] = @p2
        pattern[[2, 1]] = @p2
        pattern[[1, 2]] = @p2
        pattern[[0, 3]] = @p2
        red_patterns << pattern

        @patterns = {
            @p1 => black_patterns,
            @p2 => red_patterns
        }

    end
end
