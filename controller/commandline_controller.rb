require_relative "../model/board"
require_relative "../model/player/ai_player"
require_relative "../model/player/real_player"
require_relative "../model/game/game"
require 'contracts'

class CMDController

    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants

    Contract None => Any
    def initialize()
        Dir["../model/game/*"].each {|file| require file }

        @players = []
        @board = nil
        @player_playing = nil
    end

    Contract String => GameMode
    def create_game(game, p1 = nil, p2 = nil)
        gameClazz = Object.const_get(game) # GameMode
        if gameClazz.superclass == Game
            @game = gameClazz.new(p1, p2)
            @board = Board.new(@game.board_width, @game.board_height)
            @players.push(@game.p1)
            @players.push(@game.p2)
            @player_playing = @players.shuffle[0]
        else
            raise StandardError, "#{gameClazz} not a Game."
        end
        return @game
    end

    Contract Maybe[Nat] => nil
    def take_turn(arg)
        if @player_playing.is_a? ai_player
            player.play(@board)
        else
            @board.set_piece(arg)
        end
        # switch turns
        @player_playing = @players.reverse[@players.index(@player_playing)]
        return nil
    end

    Contract Contracts::Nat => Player
    def get_player(playerId)
        return nil
    end

    Contract Contracts::Nat => Board
    def get_board()
        return @board
    end

end

