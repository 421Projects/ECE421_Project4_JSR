require "test/unit"
require_relative "player/player"
require_relative "player/ai_player"
require_relative "board"
require_relative "game/game"
require_relative "game/connect4"
require_relative "game/otto_toot"


class Connect4ModelTest < Test::Unit::TestCase

    def test_player_board_connect4Mode

        game = Connect4.new()

        p1 = Player.new(game.p1_piece, game.p1_patterns)
        p2 = Player.new(game.p2_piece, game.p2_patterns)

        b = Board.new(game.board_width, game.board_height)
        b.set_piece(1, p1.piece)
        assert_equal(b.piece_count, 1)
        b.set_piece(1, p1.piece)
        assert_equal(b.piece_count, 2)
        b.set_piece(1, p1.piece)
        assert_equal(b.piece_count, 3)
        b.set_piece(1, p1.piece)
        assert_equal(b.piece_count, 4)

        assert_equal(b.analyze(p1.pattern_array), true,
                     "Didn't detect win.")
        assert_equal(b.analyze(p2.pattern_array), false,
                     "Wrongly calculated the game to be won.")

        b = Board.new(game.board_width, game.board_height)
        b.set_piece(1, p2.piece)
        assert_equal(b.piece_count, 1)
        b.set_piece(1, p2.piece)
        assert_equal(b.piece_count, 2)
        b.set_piece(1, p2.piece)
        assert_equal(b.piece_count, 3)
        b.set_piece(1, p2.piece)
        assert_equal(b.piece_count, 4)

        assert_equal(b.analyze(p1.pattern_array), false,
                     "Wrongly calculated the game to be won.")
        assert_equal(b.analyze(p2.pattern_array), true,
                     "Didn't detect win.")

        b = Board.new(game.board_width, game.board_height)
        b.set_piece(1, p1.piece)
        assert_equal(b.piece_count, 1)
        b.set_piece(2, p1.piece)
        assert_equal(b.piece_count, 2)
        b.set_piece(3, p1.piece)
        assert_equal(b.piece_count, 3)
        b.set_piece(4, p1.piece)
        assert_equal(b.piece_count, 4)

        assert_equal(b.analyze(p1.pattern_array), true,
                     "Didn't detect win.")
        assert_equal(b.analyze(p2.pattern_array), false,
                     "Wrongly calculated the game to be won.")

        b = Board.new(game.board_width, game.board_height)
        b.set_piece(1, p2.piece)
        assert_equal(b.piece_count, 1)
        b.set_piece(2, p2.piece)
        assert_equal(b.piece_count, 2)
        b.set_piece(3, p2.piece)
        assert_equal(b.piece_count, 3)
        b.set_piece(4, p2.piece)
        assert_equal(b.piece_count, 4)

        assert_equal(b.analyze(p1.pattern_array), false,
                     "Wrongly calculated the game to be won.")
        assert_equal(b.analyze(p2.pattern_array), true,
                     "Didn't detect win.")


        # Test diagonal win (/) for BlackPiece
        b = Board.new(game.board_width, game.board_height)
        b.set_piece(1, p1.piece)
        assert_equal(b.piece_count, 1)

        b.set_piece(2, p2.piece)
        assert_equal(b.piece_count, 2)
        b.set_piece(2, p1.piece)
        assert_equal(b.piece_count, 3)

        b.set_piece(3, p2.piece)
        assert_equal(b.piece_count, 4)
        b.set_piece(3, p2.piece)
        assert_equal(b.piece_count, 5)
        b.set_piece(3, p1.piece)
        assert_equal(b.piece_count, 6)

        b.set_piece(4, p2.piece)
        assert_equal(b.piece_count, 7)
        b.set_piece(4, p2.piece)
        assert_equal(b.piece_count, 8)
        b.set_piece(4, p2.piece)
        assert_equal(b.piece_count, 9)
        b.set_piece(4, p1.piece)
        assert_equal(b.piece_count, 10)

        assert_equal(b.analyze(p1.pattern_array), true,
                     "Didn't detect win.")
        assert_equal(b.analyze(p2.pattern_array), false,
                     "Wrongly calculated the game to be won.")

        # Test diagonal win (\) for BlackPiece
        b = Board.new(game.board_width, game.board_height)
        b.set_piece(1, p2.piece)
        assert_equal(b.piece_count, 1)
        b.set_piece(1, p2.piece)
        assert_equal(b.piece_count, 2)
        b.set_piece(1, p2.piece)
        assert_equal(b.piece_count, 3)
        b.set_piece(1, p1.piece)
        assert_equal(b.piece_count, 4)

        b.set_piece(2, p2.piece)
        assert_equal(b.piece_count, 5)
        b.set_piece(2, p2.piece)
        assert_equal(b.piece_count, 6)
        b.set_piece(2, p1.piece)
        assert_equal(b.piece_count, 7)

        b.set_piece(3, p2.piece)
        assert_equal(b.piece_count, 8)
        b.set_piece(3, p1.piece)
        assert_equal(b.piece_count, 9)

        b.set_piece(4, p1.piece)
        assert_equal(b.piece_count, 10)

        assert_equal(b.analyze(p1.pattern_array), true,
                     "Didn't detect win.")
        assert_equal(b.analyze(p2.pattern_array), false,
                     "Wrongly calculated the game to be won.")

        # Test diagonal win (/) for RedPiece
        b = Board.new(game.board_width, game.board_height)
        b.set_piece(1, p2.piece)
        assert_equal(b.piece_count, 1)

        b.set_piece(2, p1.piece)
        assert_equal(b.piece_count, 2)
        b.set_piece(2, p2.piece)
        assert_equal(b.piece_count, 3)

        b.set_piece(3, p1.piece)
        assert_equal(b.piece_count, 4)
        b.set_piece(3, p1.piece)
        assert_equal(b.piece_count, 5)
        b.set_piece(3, p2.piece)
        assert_equal(b.piece_count, 6)

        b.set_piece(4, p1.piece)
        assert_equal(b.piece_count, 7)
        b.set_piece(4, p1.piece)
        assert_equal(b.piece_count, 8)
        b.set_piece(4, p1.piece)
        assert_equal(b.piece_count, 9)
        b.set_piece(4, p2.piece)
        assert_equal(b.piece_count, 10)

        assert_equal(b.analyze(p2.pattern_array), true,
                     "Didn't detect win.")
        assert_equal(b.analyze(p1.pattern_array), false,
                     "Wrongly calculated the game to be won.")

        # Test diagonal win (\) for RedPiece
        b = Board.new(game.board_width, game.board_height)
        b.set_piece(1, p1.piece)
        assert_equal(b.piece_count, 1)
        b.set_piece(1, p1.piece)
        assert_equal(b.piece_count, 2)
        b.set_piece(1, p1.piece)
        assert_equal(b.piece_count, 3)
        b.set_piece(1, p2.piece)
        assert_equal(b.piece_count, 4)

        b.set_piece(2, p1.piece)
        assert_equal(b.piece_count, 5)
        b.set_piece(2, p1.piece)
        assert_equal(b.piece_count, 6)
        b.set_piece(2, p2.piece)
        assert_equal(b.piece_count, 7)

        b.set_piece(3, p1.piece)
        assert_equal(b.piece_count, 8)
        b.set_piece(3, p2.piece)
        assert_equal(b.piece_count, 9)

        b.set_piece(4, p2.piece)
        assert_equal(b.piece_count, 10)

        assert_equal(b.analyze(p2.pattern_array), true,
                     "Didn't detect win.")
        assert_equal(b.analyze(p1.pattern_array), false,
                     "Wrongly calculated the game to be won.")
    end

    def test_player_board_otto_toot_mode
        
        game = OttoToot.new()

        p1 = Player.new(game.p1_piece, game.p1_patterns) # Wins with OTTO
        p2 = Player.new(game.p2_piece, game.p2_patterns) # Wins with TOOT

        b = Board.new(game.board_width, game.board_height)
        b.set_piece(1, p1.piece)
        assert_equal(b.piece_count, 1)
        b.set_piece(1, p2.piece)
        assert_equal(b.piece_count, 2)
        b.set_piece(1, p2.piece)
        assert_equal(b.piece_count, 3)
        b.set_piece(1, p1.piece)
        assert_equal(b.piece_count, 4)

        assert_equal(b.analyze(p1.pattern_array), true,
                     "Didn't detect win.")
        assert_equal(b.analyze(p2.pattern_array), false,
                     "Wrongly calculated the game to be won.")

        b = Board.new(game.board_width, game.board_height)
        b.set_piece(1, p2.piece)
        assert_equal(b.piece_count, 1)
        b.set_piece(1, p1.piece)
        assert_equal(b.piece_count, 2)
        b.set_piece(1, p1.piece)
        assert_equal(b.piece_count, 3)
        b.set_piece(1, p2.piece)
        assert_equal(b.piece_count, 4)

        assert_equal(b.analyze(p1.pattern_array), false,
                     "Wrongly calculated the game to be won.")
        assert_equal(b.analyze(p2.pattern_array), true,
                     "Didn't detect win.")

        b = Board.new(game.board_width, game.board_height)
        b.set_piece(1, p1.piece)
        assert_equal(b.piece_count, 1)
        b.set_piece(2, p2.piece)
        assert_equal(b.piece_count, 2)
        b.set_piece(3, p2.piece)
        assert_equal(b.piece_count, 3)
        b.set_piece(4, p1.piece)
        assert_equal(b.piece_count, 4)

        assert_equal(b.analyze(p1.pattern_array), true,
                     "Didn't detect win.")
        assert_equal(b.analyze(p2.pattern_array), false,
                     "Wrongly calculated the game to be won.")

        b = Board.new(game.board_width, game.board_height)
        b.set_piece(1, p2.piece)
        assert_equal(b.piece_count, 1)
        b.set_piece(2, p1.piece)
        assert_equal(b.piece_count, 2)
        b.set_piece(3, p1.piece)
        assert_equal(b.piece_count, 3)
        b.set_piece(4, p2.piece)
        assert_equal(b.piece_count, 4)

        assert_equal(b.analyze(p1.pattern_array), false,
                     "Wrongly calculated the game to be won.")
        assert_equal(b.analyze(p2.pattern_array), true,
                     "Didn't detect win.")


        # Test diagonal win (/) for p1 piece
        b = Board.new(game.board_width, game.board_height)
        b.set_piece(1, p1.piece)
        assert_equal(b.piece_count, 1)

        b.set_piece(2, p2.piece)
        assert_equal(b.piece_count, 2)
        b.set_piece(2, p2.piece)
        assert_equal(b.piece_count, 3)

        b.set_piece(3, p2.piece)
        assert_equal(b.piece_count, 4)
        b.set_piece(3, p2.piece)
        assert_equal(b.piece_count, 5)
        b.set_piece(3, p2.piece)
        assert_equal(b.piece_count, 6)

        b.set_piece(4, p2.piece)
        assert_equal(b.piece_count, 7)
        b.set_piece(4, p2.piece)
        assert_equal(b.piece_count, 8)
        b.set_piece(4, p2.piece)
        assert_equal(b.piece_count, 9)
        b.set_piece(4, p1.piece)
        assert_equal(b.piece_count, 10)

        assert_equal(b.analyze(p1.pattern_array), true,
                     "Didn't detect win.")
        assert_equal(b.analyze(p2.pattern_array), false,
                     "Wrongly calculated the game to be won.")

        # Test diagonal win (\) for p1 piece
        b = Board.new(game.board_width, game.board_height)
        b.set_piece(1, p1.piece)
        assert_equal(b.piece_count, 1)
        b.set_piece(1, p2.piece)
        assert_equal(b.piece_count, 2)
        b.set_piece(1, p2.piece)
        assert_equal(b.piece_count, 3)
        b.set_piece(1, p1.piece)
        assert_equal(b.piece_count, 4)

        b.set_piece(2, p2.piece)
        assert_equal(b.piece_count, 5)
        b.set_piece(2, p2.piece)
        assert_equal(b.piece_count, 6)
        b.set_piece(2, p2.piece)
        assert_equal(b.piece_count, 7)

        b.set_piece(3, p2.piece)
        assert_equal(b.piece_count, 8)
        b.set_piece(3, p2.piece)
        assert_equal(b.piece_count, 9)

        b.set_piece(4, p1.piece)
        assert_equal(b.piece_count, 10)

        assert_equal(b.analyze(p1.pattern_array), true,
                     "Didn't detect win.")
        assert_equal(b.analyze(p2.pattern_array), false,
                     "Wrongly calculated the game to be won.")

        # Test diagonal win (/) for p2 piece
        b = Board.new(game.board_width, game.board_height)
        b.set_piece(1, p2.piece)
        assert_equal(b.piece_count, 1)

        b.set_piece(2, p1.piece)
        assert_equal(b.piece_count, 2)
        b.set_piece(2, p1.piece)
        assert_equal(b.piece_count, 3)

        b.set_piece(3, p1.piece)
        assert_equal(b.piece_count, 4)
        b.set_piece(3, p1.piece)
        assert_equal(b.piece_count, 5)
        b.set_piece(3, p1.piece)
        assert_equal(b.piece_count, 6)

        b.set_piece(4, p1.piece)
        assert_equal(b.piece_count, 7)
        b.set_piece(4, p1.piece)
        assert_equal(b.piece_count, 8)
        b.set_piece(4, p1.piece)
        assert_equal(b.piece_count, 9)
        b.set_piece(4, p2.piece)
        assert_equal(b.piece_count, 10)

        assert_equal(b.analyze(p2.pattern_array), true,
                     "Didn't detect win.")
        assert_equal(b.analyze(p1.pattern_array), false,
                     "Wrongly calculated the game to be won.")

        # Test diagonal win (\) for p2 piece
        b = Board.new(game.board_width, game.board_height)
        b.set_piece(1, p1.piece)
        assert_equal(b.piece_count, 1)
        b.set_piece(1, p1.piece)
        assert_equal(b.piece_count, 2)
        b.set_piece(1, p1.piece)
        assert_equal(b.piece_count, 3)
        b.set_piece(1, p2.piece)
        assert_equal(b.piece_count, 4)

        b.set_piece(2, p1.piece)
        assert_equal(b.piece_count, 5)
        b.set_piece(2, p1.piece)
        assert_equal(b.piece_count, 6)
        b.set_piece(2, p1.piece)
        assert_equal(b.piece_count, 7)

        b.set_piece(3, p1.piece)
        assert_equal(b.piece_count, 8)
        b.set_piece(3, p1.piece)
        assert_equal(b.piece_count, 9)

        b.set_piece(4, p2.piece)
        assert_equal(b.piece_count, 10)

        assert_equal(b.analyze(p2.pattern_array), true,
                     "Didn't detect win.")
        assert_equal(b.analyze(p1.pattern_array), false,
                     "Wrongly calculated the game to be won.")
    end


    def test_board_placement
        game = Connect4.new()

        p1 = Player.new(game.p1_piece, game.p1_patterns)

        b = Board.new(1,1)

        b.set_piece(1, p1.piece)
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

    def test_ai_basic_play

        game = Connect4.new()

        p1 = AIPlayer.new(game.p1_piece, game.p1_patterns)
        p2 = AIPlayer.new(game.p2_piece, game.p2_patterns)

        b = Board.new(game.board_height, game.board_width)
        assert_equal(b.piece_count, 0)

        p1.play(b)
        assert_equal(b.piece_count, 1)

        p1.play(b)
        assert_equal(b.piece_count, 2)

        p1.play(b)
        assert_equal(b.piece_count, 3)

        p1.play(b)
        assert_equal(b.piece_count, 4)

        assert_equal(b.analyze(p1.pattern_array), true,
                     "Didn't detect win.")
        assert_equal(b.analyze(p2.pattern_array), false,
                     "Wrongly calculated the game to be won.")

        b = Board.new(game.board_height, game.board_width)
        assert_equal(b.piece_count, 0)

        p2.play(b)
        assert_equal(b.piece_count, 1)

        p2.play(b)
        assert_equal(b.piece_count, 2)

        p2.play(b)
        assert_equal(b.piece_count, 3)

        p2.play(b)
        assert_equal(b.piece_count, 4)

        assert_equal(b.analyze(p2.pattern_array), true,
                     "Didn't detect win.")
        assert_equal(b.analyze(p1.pattern_array), false,
                     "Wrongly calculated the game to be won.")

    end

    def test_game_constructor
        assert_raise NotImplementedError do
            thrown = GameMode.new
        end
    end

end
