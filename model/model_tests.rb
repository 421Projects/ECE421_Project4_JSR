require "test/unit"
require "./player/player"
require "./game_pieces/game_piece"
require "./game_pattern"
require "./board"
require "./game_pieces/black"
require "./game_pieces/red"
require "./game_pieces/o"
require "./game_pieces/t"


class Connect4ModelTest < Test::Unit::TestCase

    def test_create_piece
        BlackPiece.new()
        RedPiece.new()
        assert(true)
    end

    def test_create_pattern
        black_patterns = []
        pattern = Hash.new
        pattern[[0, 0]] = BlackPiece.new
        pattern[[0, 1]] = BlackPiece.new
        pattern[[0, 2]] = BlackPiece.new
        pattern[[0, 3]] = BlackPiece.new
        black_patterns << pattern

        pattern = Hash.new
        pattern[[0, 0]] = BlackPiece.new
        pattern[[1, 0]] = BlackPiece.new
        pattern[[2, 0]] = BlackPiece.new
        pattern[[3, 0]] = BlackPiece.new
        black_patterns << pattern

        pattern = Hash.new
        pattern[[0, 0]] = BlackPiece.new
        pattern[[1, 1]] = BlackPiece.new
        pattern[[2, 2]] = BlackPiece.new
        pattern[[3, 3]] = BlackPiece.new
        black_patterns << pattern

        pattern = Hash.new
        pattern[[3, 0]] = BlackPiece.new
        pattern[[2, 1]] = BlackPiece.new
        pattern[[1, 2]] = BlackPiece.new
        pattern[[0, 3]] = BlackPiece.new
        black_patterns << pattern

        black_game_patterns = GamePattern.new(black_patterns)
        assert(true)
    end

    def test_create_player
        black_patterns = []
        pattern = Hash.new
        pattern[[0, 0]] = BlackPiece.new
        pattern[[0, 1]] = BlackPiece.new
        pattern[[0, 2]] = BlackPiece.new
        pattern[[0, 3]] = BlackPiece.new
        black_patterns << pattern

        pattern = Hash.new
        pattern[[0, 0]] = BlackPiece.new
        pattern[[1, 0]] = BlackPiece.new
        pattern[[2, 0]] = BlackPiece.new
        pattern[[3, 0]] = BlackPiece.new
        black_patterns << pattern

        pattern = Hash.new
        pattern[[0, 0]] = BlackPiece.new
        pattern[[1, 1]] = BlackPiece.new
        pattern[[2, 2]] = BlackPiece.new
        pattern[[3, 3]] = BlackPiece.new
        black_patterns << pattern

        pattern = Hash.new
        pattern[[3, 0]] = BlackPiece.new
        pattern[[2, 1]] = BlackPiece.new
        pattern[[1, 2]] = BlackPiece.new
        pattern[[0, 3]] = BlackPiece.new
        black_patterns << pattern

        black_game_patterns = GamePattern.new(black_patterns)

        red_patterns = []
        pattern = Hash.new
        pattern[[0, 0]] = RedPiece.new
        pattern[[0, 1]] = RedPiece.new
        pattern[[0, 2]] = RedPiece.new
        pattern[[0, 3]] = RedPiece.new
        red_patterns << pattern

        pattern = Hash.new
        pattern[[0, 0]] = RedPiece.new
        pattern[[1, 0]] = RedPiece.new
        pattern[[2, 0]] = RedPiece.new
        pattern[[3, 0]] = RedPiece.new
        red_patterns << pattern

        pattern = Hash.new
        pattern[[0, 0]] = RedPiece.new
        pattern[[1, 1]] = RedPiece.new
        pattern[[2, 2]] = RedPiece.new
        pattern[[3, 3]] = RedPiece.new
        red_patterns << pattern

        pattern = Hash.new
        pattern[[3, 0]] = RedPiece.new
        pattern[[2, 1]] = RedPiece.new
        pattern[[1, 2]] = RedPiece.new
        pattern[[0, 3]] = RedPiece.new
        red_patterns << pattern

        red_game_patterns = GamePattern.new(red_patterns)

        p1 = Player.new(black_game_patterns, BlackPiece.new)
        p2 = Player.new(red_game_patterns, RedPiece.new)

        assert(true)
    end

    def test_create_board
        # place piece in same place
        # place different piece in same place
        # place off of board (in y direction, in x direction...)
        # dont include piece
        # dont include coords
        b = Board.new(6,7)
        b.set_piece(1,1, BlackPiece.new)
        assert_equal(b.get_piece_count, 1)
        b.set_piece(1,0, Red.new)
        assert_equal(b.get_piece_count, 2)
    end

end

