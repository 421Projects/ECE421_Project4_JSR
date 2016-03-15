require "test/unit"
require_relative "game_controller"
require_relative "../model/board"
require_relative "../model/game_mode/connect4"
require_relative "../model/game_mode/otto_toot"
require_relative "../model/game_pieces/black.rb"

class ControllerTest < Test::Unit::TestCase

    def test_create_game
        game_controller = GameController.new
        game_mode = game_controller.create_game("Connect4")

        assert(game_mode.is_a?(Connect4))

        game_controller = GameController.new
        game_mode = game_controller.create_game("OttoToot")

        assert(game_mode.is_a?(OttoToot))
    end

    def test_place_piece
        game_controller = GameController.new
        game_mode = game_controller.create_game("Connect4")

        piece = Black.new

        game_controller.place_piece(piece, 1)

        board = game_controller.get_board()
        assert_equal(piece, board.get_piece(1, board.height-1))
    end

    def test_create_real_player
        game_controller = GameController.new
        game_mode = game_controller.create_game("Connect4")

        game_controller.create_real_players(1)

        assert_equal(1, game_controller.get_number_of_players)
    end

    def test_create_ai_player
        game_controller = GameController.new
        game_mode = game_controller.create_game("Connect4")

        game_controller.create_ai_players(1)

        assert_equal(1, game_controller.get_number_of_players)
    end

end