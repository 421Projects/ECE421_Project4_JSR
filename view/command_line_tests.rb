require "test/unit"
require "../controller/game_controller"
require_relative "command_line"

class CommandLineViewTest < Test::Unit::TestCase

    @@commands = ["new", "print", "place", "quit"]

    def test_new
        s = CommandLineView.new
        
        connect4_game = s.parseCommand(["new", "connect4"])
        assert(connect4_game.is_a?(Connect4))
        
        connect4_game = s.parseCommand(["new", "ottotoot"])
        assert(connect4_game.is_a?(Connect4))
    end
    
    def test_place
        s = CommandLineView.new
        
        connect4_game = s.parseCommand(["new", "connect4"])
        assert(connect4_game.is_a?(Connect4))
        
        connect4_game = s.parseCommand(["place", "1", "3"])
    end
    
    def test_quit
        s = CommandLineView.new
        
        connect4_game = s.parseCommand(["new", "connect4"])
        assert(connect4_game.is_a?(Connect4))
        
        connect4_game = s.parseCommand(["quit"])
    end

end

