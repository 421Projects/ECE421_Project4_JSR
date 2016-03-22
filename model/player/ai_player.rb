require "contracts"
require_relative "./player"

class AIPlayer < Player

    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants

    Contract String, ArrayOf[HashOf[[Nat, Nat], String]], String, ArrayOf[HashOf[[Nat, Nat], String]], Maybe[Nat], Maybe[String] => Any
    def initialize(piece, patterns, opposing_piece, opposing_patterns, depth = 2, name=piece+":Player")
        super(piece, patterns, name)
        @original_piece = piece
        @piece = @original_piece
        @name = name
        @pattern_array = patterns
        @opposing_piece = opposing_piece
        @opposing_patterns = opposing_patterns
        @depth = depth
    end

    Contract Board => nil
    def play(board_to_play)
        place = maximize(board_to_play, @depth)[1]
        board_to_play.set_piece(place, @piece)
        nil
    end

    Contract Board, Nat => ArrayOf[Integer]
    def minimize(board, depth)
        depth = depth - 1
        best_value = 999999999
        best_index = -1        

        board.width.times do |index|
            new_board = board.copy
            begin                
                new_board.set_piece(index, @opposing_piece)
            rescue Board::ColumnFullError
                next
            end

            if depth <= 0
                score = score_of_board(new_board, @pattern_array) - score_of_board(new_board, @opposing_patterns) 
                if score < best_value
                    best_value = score
                    best_index = index
                end
            else
                score = minimize(new_board, depth)
                if score[0] < best_value
                    best_value = score[0]
                    best_index = index
                end
            end            
        end

        return [best_value, best_index] 
    end

    Contract Board, Nat => ArrayOf[Integer]
    def maximize(board, depth)
        depth = depth - 1
        best_value = -999999999
        best_index = -1        

        board.width.times do |index|
            new_board = board.copy
            begin                
                new_board.set_piece(index, @piece)
            rescue Board::ColumnFullError
                next
            end

            if depth <= 0
                score = score_of_board(new_board, @pattern_array) - score_of_board(new_board, @opposing_patterns) 
                if score > best_value
                    best_value = score
                    best_index = index
                end
            else
                score = minimize(new_board, depth)
                if score[0] > best_value
                    best_value = score[0]
                    best_index = index
                end
            end            
        end

        return [best_value, best_index] 
    end

    Contract HashOf[[Nat, Nat], String], Board => Integer
    def score_of_pattern(pattern, board)
        score = 0
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
                score = score + heuristic(pattern, board, row, column)
            end
        end

        return score
    end

    Contract Board, ArrayOf[HashOf[[Nat, Nat], String]] => Integer
    def score_of_board(board, patterns)
        value = 0
        patterns.each do |pattern|
            value = value + score_of_pattern(pattern, board)
        end

        # opposing_patterns.each do |pattern|
        #     value = value - score_of_pattern(pattern, board)
        # end

        return value
    end

    # This function searches a single spot of the board.
    # It asigns scores based upon how closely the board position described,
    # matches the pattern. 
    Contract HashOf[[Nat, Nat], String], Board, Nat, Nat => Integer
    def heuristic(pattern, board, row_offset, col_offset)
        good_pieces = 0

        pattern.each do |key, value|
            p_row_offset = key[0]
            p_col_offset = key[1]

            board_piece = board.get_player_on_pos(p_row_offset + row_offset, p_col_offset + col_offset)

            if board_piece == value
                good_pieces += 1
            elsif board_piece != "*"
                return 0
            end
        end

        return (10 ** (good_pieces - 1)).floor
    end
end
