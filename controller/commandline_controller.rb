require_relative "../model/board"
require_relative "../model/player/ai_player"
require_relative "../model/player/real_player"
require_relative "../model/game/game"
require 'contracts'

class CMDController

    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants

    #Contract None => Any
    def self.initialize()
        Dir["../model/game/*"].each {|file| require file }

        @players = []
        @board = nil
        @player_playing = nil
    end

    def self.get_player_playing
        return @player_playing
    end

    #Contract String => GameMode
    def self.create_game(game, p1 = nil, p2 = nil)
        gameClazz = Object.const_get(game) # GameMode
        if gameClazz.superclass == GameMode
            @game = gameClazz.new(p1, p2)
            @board = Board.new(@game.board_width, @game.board_height)
            puts @board
            @players.push(@game.p1)
            @players.push(@game.p2)
            @player_playing = @players.shuffle[0]
        else
            raise StandardError, "#{gameClazz} not a Game."
        end
        return @game
    end

    #Contract Maybe[Nat] => nil
    def self.take_turn(arg)
        if arg == nil
            return arg
        end
        if @player_playing.is_a? AIPlayer
            @board.set_piece(player.play(@board), @player_playing)
        else
            @board.set_piece(arg, @player_playing)
        end
        # switch turns
        @player_playing = @players[@players.index(@player_playing)+1]
        if @player_playing == nil
            @player_playing = @players[0]
        end
        return nil
    end

    def self.get_board()
        return @board
    end

    def self.handle_event(commands)
        if commands[0].downcase.include? "new" or
          commands[0].downcase.include? "create"
            if commands[1].downcase.include? "connect"
                self.create_game("Connect4")
            elsif commands[1].downcase.include? "otto"
                self.create_game("OttoToot")
            end
        elsif commands[0].downcase.include? "restart" or
          commands[0].downcase.include? "reset"
            @players = []
            @board = nil
            @player_playing = nil
        else
            i = Integer(commands[0]) rescue nil
            puts i
            self.take_turn(i)
        end

    end

    #Contract Contracts::Nat => Player
    def get_player(playerId)
        return nil
    end

    #Contract Contracts::Nat => Board
    def get_board()
        return @board
    end

end

