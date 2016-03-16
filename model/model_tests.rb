require "test/unit"
require "./player/player"
require "./game_pieces/game_piece"
require "./game_pattern"
require "./board"
require "./game_pieces/black"
require "./game_pieces/red"
require "./game_pieces/o"
require "./game_pieces/t"
require_relative "game_mode/game_mode"


class Connect4ModelTest < Test::Unit::TestCase

    def test_create_piece
        b = BlackPiece.new()
        r = RedPiece.new()

        assert(b.is_a? GamePiece)
        assert(r.is_a? GamePiece)

        assert(b.respond_to? "play")
        assert(r.respond_to? "play")
        assert(g.respond_to? "play")
    end

    def test_create_pattern_player_board_connect4Mode
        black_patterns = []
        pattern = GamePattern.new
        pattern[[0, 0]] = BlackPiece.new
        pattern[[0, 1]] = BlackPiece.new
        pattern[[0, 2]] = BlackPiece.new
        pattern[[0, 3]] = BlackPiece.new
        black_patterns << pattern

        pattern = GamePattern.new
        pattern[[0, 0]] = BlackPiece.new
        pattern[[1, 0]] = BlackPiece.new
        pattern[[2, 0]] = BlackPiece.new
        pattern[[3, 0]] = BlackPiece.new
        black_patterns << pattern

        pattern = GamePattern.new
        pattern[[0, 0]] = BlackPiece.new
        pattern[[1, 1]] = BlackPiece.new
        pattern[[2, 2]] = BlackPiece.new
        pattern[[3, 3]] = BlackPiece.new
        black_patterns << pattern

        pattern = GamePattern.new
        pattern[[3, 0]] = BlackPiece.new
        pattern[[2, 1]] = BlackPiece.new
        pattern[[1, 2]] = BlackPiece.new
        pattern[[0, 3]] = BlackPiece.new
        black_patterns << pattern

        red_patterns = []
        pattern = GamePattern.new
        pattern[[0, 0]] = RedPiece.new
        pattern[[0, 1]] = RedPiece.new
        pattern[[0, 2]] = RedPiece.new
        pattern[[0, 3]] = RedPiece.new
        red_patterns << pattern

        pattern = GamePattern.new
        pattern[[0, 0]] = RedPiece.new
        pattern[[1, 0]] = RedPiece.new
        pattern[[2, 0]] = RedPiece.new
        pattern[[3, 0]] = RedPiece.new
        red_patterns << pattern

        pattern = GamePattern.new
        pattern[[0, 0]] = RedPiece.new
        pattern[[1, 1]] = RedPiece.new
        pattern[[2, 2]] = RedPiece.new
        pattern[[3, 3]] = RedPiece.new
        red_patterns << pattern

        pattern = GamePattern.new
        pattern[[3, 0]] = RedPiece.new
        pattern[[2, 1]] = RedPiece.new
        pattern[[1, 2]] = RedPiece.new
        pattern[[0, 3]] = RedPiece.new
        red_patterns << pattern

        p1 = Player.new(black_patterns, BlackPiece.new)
        p2 = Player.new(red_patterns, RedPiece.new)

        b = Board.new(6,7)
        b.set_piece(1, BlackPiece.new)
        assert_equal(b.get_piece_count, 1)
        b.set_piece(1, BlackPiece.new)
        assert_equal(b.get_piece_count, 2)
        b.set_piece(1, BlackPiece.new)
        assert_equal(b.get_piece_count, 3)
        b.set_piece(1, BlackPiece.new)
        assert_equal(b.get_piece_count, 4)

        assert_equal(b.analyze(p1.pattern_array), true,
                     "Didn't detect win.")
        assert_equal(b.analyze(p2.pattern_array), false,
                     "Wrongly calculated the game to be won.")

        b = Board.new(6,7)
        b.set_piece(1, RedPiece.new)
        assert_equal(b.get_piece_count, 1)
        b.set_piece(1, RedPiece.new)
        assert_equal(b.get_piece_count, 2)
        b.set_piece(1, RedPiece.new)
        assert_equal(b.get_piece_count, 3)
        b.set_piece(1, RedPiece.new)
        assert_equal(b.get_piece_count, 4)

        assert_equal(b.analyze(p1.pattern_array), false,
                     "Wrongly calculated the game to be won.")
        assert_equal(b.analyze(p2.pattern_array), true,
                     "Didn't detect win.")

        b = Board.new(6,7)
        b.set_piece(1, BlackPiece.new)
        assert_equal(b.get_piece_count, 1)
        b.set_piece(2, BlackPiece.new)
        assert_equal(b.get_piece_count, 2)
        b.set_piece(3, BlackPiece.new)
        assert_equal(b.get_piece_count, 3)
        b.set_piece(4, BlackPiece.new)
        assert_equal(b.get_piece_count, 4)

        assert_equal(b.analyze(p1.pattern_array), true,
                     "Didn't detect win.")
        assert_equal(b.analyze(p2.pattern_array), false,
                     "Wrongly calculated the game to be won.")

        b = Board.new(6,7)
        b.set_piece(1, RedPiece.new)
        assert_equal(b.get_piece_count, 1)
        b.set_piece(2, RedPiece.new)
        assert_equal(b.get_piece_count, 2)
        b.set_piece(3, RedPiece.new)
        assert_equal(b.get_piece_count, 3)
        b.set_piece(4, RedPiece.new)
        assert_equal(b.get_piece_count, 4)

        assert_equal(b.analyze(p1.pattern_array), false,
                     "Wrongly calculated the game to be won.")
        assert_equal(b.analyze(p2.pattern_array), true,
                     "Didn't detect win.")


        # Test diagonal win (/) for BlackPiece
        b = Board.new(6,7)
        b.set_piece(1, BlackPiece.new)
        assert_equal(b.get_piece_count, 1)

        b.set_piece(2, RedPiece.new)
        assert_equal(b.get_piece_count, 2)
        b.set_piece(2, BlackPiece.new)
        assert_equal(b.get_piece_count, 3)

        b.set_piece(3, RedPiece.new)
        assert_equal(b.get_piece_count, 4)
        b.set_piece(3, RedPiece.new)
        assert_equal(b.get_piece_count, 5)
        b.set_piece(3, BlackPiece.new)
        assert_equal(b.get_piece_count, 6)

        b.set_piece(4, RedPiece.new)
        assert_equal(b.get_piece_count, 7)
        b.set_piece(4, RedPiece.new)
        assert_equal(b.get_piece_count, 8)
        b.set_piece(4, RedPiece.new)
        assert_equal(b.get_piece_count, 9)
        b.set_piece(4, BlackPiece.new)
        assert_equal(b.get_piece_count, 10)

        assert_equal(b.analyze(p1.pattern_array), true,
                     "Didn't detect win.")
        assert_equal(b.analyze(p2.pattern_array), false,
                     "Wrongly calculated the game to be won.")

        # Test diagonal win (\) for BlackPiece
        b = Board.new(6,7)
        b.set_piece(1, RedPiece.new)
        assert_equal(b.get_piece_count, 1)
        b.set_piece(1, RedPiece.new)
        assert_equal(b.get_piece_count, 2)
        b.set_piece(1, RedPiece.new)
        assert_equal(b.get_piece_count, 3)
        b.set_piece(1, BlackPiece.new)
        assert_equal(b.get_piece_count, 4)

        b.set_piece(2, RedPiece.new)
        assert_equal(b.get_piece_count, 5)
        b.set_piece(2, RedPiece.new)
        assert_equal(b.get_piece_count, 6)
        b.set_piece(2, BlackPiece.new)
        assert_equal(b.get_piece_count, 7)

        b.set_piece(3, RedPiece.new)
        assert_equal(b.get_piece_count, 8)
        b.set_piece(3, BlackPiece.new)
        assert_equal(b.get_piece_count, 9)

        b.set_piece(4, BlackPiece.new)
        assert_equal(b.get_piece_count, 10)

        assert_equal(b.analyze(p1.pattern_array), true,
                     "Didn't detect win.")
        assert_equal(b.analyze(p2.pattern_array), false,
                     "Wrongly calculated the game to be won.")

        # Test diagonal win (/) for RedPiece
        b = Board.new(6,7)
        b.set_piece(1, RedPiece.new)
        assert_equal(b.get_piece_count, 1)

        b.set_piece(2, BlackPiece.new)
        assert_equal(b.get_piece_count, 2)
        b.set_piece(2, RedPiece.new)
        assert_equal(b.get_piece_count, 3)

        b.set_piece(3, BlackPiece.new)
        assert_equal(b.get_piece_count, 4)
        b.set_piece(3, BlackPiece.new)
        assert_equal(b.get_piece_count, 5)
        b.set_piece(3, RedPiece.new)
        assert_equal(b.get_piece_count, 6)

        b.set_piece(4, BlackPiece.new)
        assert_equal(b.get_piece_count, 7)
        b.set_piece(4, BlackPiece.new)
        assert_equal(b.get_piece_count, 8)
        b.set_piece(4, BlackPiece.new)
        assert_equal(b.get_piece_count, 9)
        b.set_piece(4, RedPiece.new)
        assert_equal(b.get_piece_count, 10)

        assert_equal(b.analyze(p2.pattern_array), true,
                     "Didn't detect win.")
        assert_equal(b.analyze(p1.pattern_array), false,
                     "Wrongly calculated the game to be won.")

        # Test diagonal win (\) for RedPiece
        b = Board.new(6,7)
        b.set_piece(1, BlackPiece.new)
        assert_equal(b.get_piece_count, 1)
        b.set_piece(1, BlackPiece.new)
        assert_equal(b.get_piece_count, 2)
        b.set_piece(1, BlackPiece.new)
        assert_equal(b.get_piece_count, 3)
        b.set_piece(1, RedPiece.new)
        assert_equal(b.get_piece_count, 4)

        b.set_piece(2, BlackPiece.new)
        assert_equal(b.get_piece_count, 5)
        b.set_piece(2, BlackPiece.new)
        assert_equal(b.get_piece_count, 6)
        b.set_piece(2, RedPiece.new)
        assert_equal(b.get_piece_count, 7)

        b.set_piece(3, BlackPiece.new)
        assert_equal(b.get_piece_count, 8)
        b.set_piece(3, RedPiece.new)
        assert_equal(b.get_piece_count, 9)

        b.set_piece(4, RedPiece.new)
        assert_equal(b.get_piece_count, 10)

        assert_equal(b.analyze(p2.pattern_array), true,
                     "Didn't detect win.")
        assert_equal(b.analyze(p1.pattern_array), false,
                     "Wrongly calculated the game to be won.")
    end

    def test_create_pattern_player_board_ottoTootMode
        p1_patterns = []
        pattern = GamePattern.new
        pattern[[0, 0]] = OPiece.new
        pattern[[0, 1]] = TPiece.new
        pattern[[0, 2]] = TPiece.new
        pattern[[0, 3]] = OPiece.new
        p1_patterns << pattern

        pattern = GamePattern.new
        pattern[[0, 0]] = OPiece.new
        pattern[[1, 0]] = TPiece.new
        pattern[[2, 0]] = TPiece.new
        pattern[[3, 0]] = OPiece.new
        p1_patterns << pattern

        pattern = GamePattern.new
        pattern[[0, 0]] = OPiece.new
        pattern[[1, 1]] = TPiece.new
        pattern[[2, 2]] = TPiece.new
        pattern[[3, 3]] = OPiece.new
        p1_patterns << pattern

        pattern = GamePattern.new
        pattern[[3, 0]] = OPiece.new
        pattern[[2, 1]] = TPiece.new
        pattern[[1, 2]] = TPiece.new
        pattern[[0, 3]] = OPiece.new
        p1_patterns << pattern

        p2_patterns = []
        pattern = GamePattern.new
        pattern[[0, 0]] = TPiece.new
        pattern[[0, 1]] = OPiece.new
        pattern[[0, 2]] = OPiece.new
        pattern[[0, 3]] = TPiece.new
        p2_patterns << pattern

        pattern = GamePattern.new
        pattern[[0, 0]] = TPiece.new
        pattern[[1, 0]] = OPiece.new
        pattern[[2, 0]] = OPiece.new
        pattern[[3, 0]] = TPiece.new
        p2_patterns << pattern

        pattern = GamePattern.new
        pattern[[0, 0]] = TPiece.new
        pattern[[1, 1]] = OPiece.new
        pattern[[2, 2]] = OPiece.new
        pattern[[3, 3]] = TPiece.new
        p2_patterns << pattern

        pattern = GamePattern.new
        pattern[[3, 0]] = TPiece.new
        pattern[[2, 1]] = OPiece.new
        pattern[[1, 2]] = OPiece.new
        pattern[[0, 3]] = TPiece.new
        p2_patterns << pattern

        p1 = Player.new(p1_patterns, OPiece.new)
        p2 = Player.new(p2_patterns, TPiece.new)

        b = Board.new(6,7)
        b.set_piece(1, OPiece.new)
        assert_equal(b.get_piece_count, 1)
        b.set_piece(1, TPiece.new)
        assert_equal(b.get_piece_count, 2)
        b.set_piece(1, TPiece.new)
        assert_equal(b.get_piece_count, 3)
        b.set_piece(1, OPiece.new)
        assert_equal(b.get_piece_count, 4)

        assert_equal(b.analyze(p1.pattern_array), true,
                     "Didn't detect win.")
        assert_equal(b.analyze(p2.pattern_array), false,
                     "Wrongly calculated the game to be won.")

        b = Board.new(6,7)
        b.set_piece(1, TPiece.new)
        assert_equal(b.get_piece_count, 1)
        b.set_piece(1, OPiece.new)
        assert_equal(b.get_piece_count, 2)
        b.set_piece(1, OPiece.new)
        assert_equal(b.get_piece_count, 3)
        b.set_piece(1, TPiece.new)
        assert_equal(b.get_piece_count, 4)

        assert_equal(b.analyze(p1.pattern_array), false,
                     "Wrongly calculated the game to be won.")
        assert_equal(b.analyze(p2.pattern_array), true,
                     "Didn't detect win.")

        b = Board.new(6,7)
        b.set_piece(1, OPiece.new)
        assert_equal(b.get_piece_count, 1)
        b.set_piece(2, TPiece.new)
        assert_equal(b.get_piece_count, 2)
        b.set_piece(3, TPiece.new)
        assert_equal(b.get_piece_count, 3)
        b.set_piece(4, OPiece.new)
        assert_equal(b.get_piece_count, 4)

        assert_equal(b.analyze(p1.pattern_array), true,
                     "Didn't detect win.")
        assert_equal(b.analyze(p2.pattern_array), false,
                     "Wrongly calculated the game to be won.")

        b = Board.new(6,7)
        b.set_piece(1, TPiece.new)
        assert_equal(b.get_piece_count, 1)
        b.set_piece(2, OPiece.new)
        assert_equal(b.get_piece_count, 2)
        b.set_piece(3, OPiece.new)
        assert_equal(b.get_piece_count, 3)
        b.set_piece(4, TPiece.new)
        assert_equal(b.get_piece_count, 4)

        assert_equal(b.analyze(p1.pattern_array), false,
                     "Wrongly calculated the game to be won.")
        assert_equal(b.analyze(p2.pattern_array), true,
                     "Didn't detect win.")


        # Test diagonal win (/) for p1 piece
        b = Board.new(6,7)
        b.set_piece(1, OPiece.new)
        assert_equal(b.get_piece_count, 1)

        b.set_piece(2, TPiece.new)
        assert_equal(b.get_piece_count, 2)
        b.set_piece(2, TPiece.new)
        assert_equal(b.get_piece_count, 3)

        b.set_piece(3, TPiece.new)
        assert_equal(b.get_piece_count, 4)
        b.set_piece(3, TPiece.new)
        assert_equal(b.get_piece_count, 5)
        b.set_piece(3, TPiece.new)
        assert_equal(b.get_piece_count, 6)

        b.set_piece(4, TPiece.new)
        assert_equal(b.get_piece_count, 7)
        b.set_piece(4, TPiece.new)
        assert_equal(b.get_piece_count, 8)
        b.set_piece(4, TPiece.new)
        assert_equal(b.get_piece_count, 9)
        b.set_piece(4, OPiece.new)
        assert_equal(b.get_piece_count, 10)

        assert_equal(b.analyze(p1.pattern_array), true,
                     "Didn't detect win.")
        assert_equal(b.analyze(p2.pattern_array), false,
                     "Wrongly calculated the game to be won.")

        # Test diagonal win (\) for p1 piece
        b = Board.new(6,7)
        b.set_piece(1, OPiece.new)
        assert_equal(b.get_piece_count, 1)
        b.set_piece(1, TPiece.new)
        assert_equal(b.get_piece_count, 2)
        b.set_piece(1, TPiece.new)
        assert_equal(b.get_piece_count, 3)
        b.set_piece(1, OPiece.new)
        assert_equal(b.get_piece_count, 4)

        b.set_piece(2, TPiece.new)
        assert_equal(b.get_piece_count, 5)
        b.set_piece(2, TPiece.new)
        assert_equal(b.get_piece_count, 6)
        b.set_piece(2, TPiece.new)
        assert_equal(b.get_piece_count, 7)

        b.set_piece(3, TPiece.new)
        assert_equal(b.get_piece_count, 8)
        b.set_piece(3, TPiece.new)
        assert_equal(b.get_piece_count, 9)

        b.set_piece(4, OPiece.new)
        assert_equal(b.get_piece_count, 10)

        assert_equal(b.analyze(p1.pattern_array), true,
                     "Didn't detect win.")
        assert_equal(b.analyze(p2.pattern_array), false,
                     "Wrongly calculated the game to be won.")

        # Test diagonal win (/) for p2 piece
        b = Board.new(6,7)
        b.set_piece(1, TPiece.new)
        assert_equal(b.get_piece_count, 1)

        b.set_piece(2, OPiece.new)
        assert_equal(b.get_piece_count, 2)
        b.set_piece(2, OPiece.new)
        assert_equal(b.get_piece_count, 3)

        b.set_piece(3, OPiece.new)
        assert_equal(b.get_piece_count, 4)
        b.set_piece(3, OPiece.new)
        assert_equal(b.get_piece_count, 5)
        b.set_piece(3, OPiece.new)
        assert_equal(b.get_piece_count, 6)

        b.set_piece(4, OPiece.new)
        assert_equal(b.get_piece_count, 7)
        b.set_piece(4, OPiece.new)
        assert_equal(b.get_piece_count, 8)
        b.set_piece(4, OPiece.new)
        assert_equal(b.get_piece_count, 9)
        b.set_piece(4, TPiece.new)
        assert_equal(b.get_piece_count, 10)

        assert_equal(b.analyze(p2.pattern_array), true,
                     "Didn't detect win.")
        assert_equal(b.analyze(p1.pattern_array), false,
                     "Wrongly calculated the game to be won.")

        # Test diagonal win (\) for p2 piece
        b = Board.new(6,7)
        b.set_piece(1, OPiece.new)
        assert_equal(b.get_piece_count, 1)
        b.set_piece(1, OPiece.new)
        assert_equal(b.get_piece_count, 2)
        b.set_piece(1, OPiece.new)
        assert_equal(b.get_piece_count, 3)
        b.set_piece(1, TPiece.new)
        assert_equal(b.get_piece_count, 4)

        b.set_piece(2, OPiece.new)
        assert_equal(b.get_piece_count, 5)
        b.set_piece(2, OPiece.new)
        assert_equal(b.get_piece_count, 6)
        b.set_piece(2, OPiece.new)
        assert_equal(b.get_piece_count, 7)

        b.set_piece(3, OPiece.new)
        assert_equal(b.get_piece_count, 8)
        b.set_piece(3, OPiece.new)
        assert_equal(b.get_piece_count, 9)

        b.set_piece(4, TPiece.new)
        assert_equal(b.get_piece_count, 10)

        assert_equal(b.analyze(p2.pattern_array), true,
                     "Didn't detect win.")
        assert_equal(b.analyze(p1.pattern_array), false,
                     "Wrongly calculated the game to be won.")
    end


    def test_board_placement
        b = Board.new(1,1)

        b.set_piece(1, BlackPiece.new)
        piece = b.get_piece(1,1)
        assert(piece.is_a?(GamePiece),
               "Piece at position (1,1) is not a GamePiece.")
        assert(b.get_piece(1,1).is_a?(BlackPiece),
               "Piece at position (1,1) is not a BlackPiece.")

        assert_raise do
            b.set_piece(1, BlackPiece.new)
        end
        assert_raise do
            b.set_piece(1, RedPiece.new)
        end
        assert(b.get_piece(1,1).is_a?(GamePiece),
               "Piece at position (1,1) is not a GamePiece.")
        assert(b.get_piece(1,1).is_a?(BlackPiece),
               "Piece at position (1,1) is not a BlackPiece.")

        assert_raise do
            b.set_piece(2341, BlackPiece.new)
        end

        assert_raise do
            b.set_piece(1)
        end

        assert_raise do
            b.set_piece(BlackPiece.new)
        end

        assert_raise do
            b.set_piece(RedPiece.new)
        end

        assert_equal(b.analyze, false,
                     "Wrongly calculated the game to be won.")
    end

    def test_game_mode_constructor
        assert_raise NotImplementedError do
            thrown = GameMode.new
        end
    end

    def test_game_piece_constructor
        assert_raise NotImplementedError do
            thrown = GamePiece.new
        end
    end

end
