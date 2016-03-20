require "contracts"
require_relative "./player"

class AIPlayer < Player

    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants

    Contract String, ArrayOf[HashOf[[Nat, Nat], String]], ArrayOf[HashOf[[Nat, Nat], String]] => Any
    def initialize(piece, patterns, opposing_patterns, name=piece+":Player")
        @original_piece = piece
        @piece = @original_piece
        @name = name
        @pattern_array = patterns
        @opposing_patterns = opposing_patterns
    end

    def play(board_to_play)
        # Enact the AI strategy here
        return (rand*board_to_play.width).to_i
    end

    def score_of_pattern(pattern, board)
        value = 0
        p_width = 0
        p_height = 0

        pattern.each { |key, value|
            if key[0] >= p_height then
                p_height = key[0] + 1
            end

            if key[1] >= p_width then
                p_width = key[1] + 1
            end
        }

        (board.height - (p_height - 1)).times do |row|
            (board.width - (p_width - 1)).times do |column|
                value = value + heuristic(pattern, board, row, column)
            end
        end

        return value
    end

    def score_of_board(board)
        value = 0
        @pattern_array.each do |value|
            value = value + score_of_pattern(value, board)
        end

        @opposing_patterns.each do |value|
            value = score_of_pattern(value, board) - value
        end

        return value
    end

    # This function searches a single spot of the board.
    # It asigns scores based upon how closely the board position described,
    # matches the pattern. 
    Contract HashOf[[Nat, Nat], String], HashOf[[Nat, Nat], String], Nat, Nat => Integer
    def heuristic(pattern, board, row_offset, col_offset)
        good_pieces = 0

        pattern.each do |key, value|
            p_row_offset = key[0]
            p_col_offset = key[1]

            board_piece = board.get_player_on_pos(p_row_offset + row_offset, p_col_offset + col_offset)

            if board_piece == value
                good_pieces += 1
            end
        end

        return 10 ** (good_pieces - 1)
    end
end
