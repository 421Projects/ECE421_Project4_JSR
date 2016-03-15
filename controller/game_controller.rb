require_relative "../model/board"
require_relative "../model/player/ai_player"
require_relative "../model/player/real_player"
require_relative "../model/game_pieces/game_piece"
require_relative "../model/game_pattern"
require_relative "../model/game_mode/game_mode"
require 'contracts'

class GameController

    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants

    Contract None => Any
    def initialize()
        Dir["../model/game_mode/*"].each {|file| require file }

        @players = []
    end

    Contract String => GameMode
    def create_game(game_mode)
        gameClazz = Object.const_get(game_mode) # GameMode
        @game = gameClazz.new()
        return @game
    end

    Contract GamePiece, Contracts::Nat => nil
    def place_piece(piece, column)
        return nil
    end

    Contract Contracts::Nat => nil
    def create_real_players(num_players)
        for i in 0..num_players - 1
            @players.push(new RealPlayer())
        end
        return nil
    end

    Contract Contracts::Nat => nil
    def create_ai_players(num_players)
        return nil
    end

    Contract None => Contracts::Nat
    def get_number_of_players()
        return @players.length
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

