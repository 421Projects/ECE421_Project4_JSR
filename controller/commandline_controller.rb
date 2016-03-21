require_relative "../model/board"
require_relative "../model/player/ai_player"
require_relative "../model/player/real_player"
require_relative "../model/game/game"
require_relative "../model/game/connect4"
require 'contracts'
require 'observer'

class CMDController

    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants

    #Contract None => Any
    def self.initialize(observer_views)
        Dir["../model/game/*"].each {|file| require_relative file }

        @observer_views = observer_views.to_a
        @players = []
        @board = nil
        @player_playing = nil
        @AI_players = 0
    end

    def self.get_player_playing
        return @player_playing
    end

    #Contract String => GameMode
    def self.create_game(game)
        gameClazz = Object.const_get(game) # GameMode
        if gameClazz.superclass == GameMode
            @game = gameClazz.new()
            patterns = [@game.p1_patterns, @game.p2_patterns]
            names = [@game.p1_piece, @game.p2_piece]
            for i in 1..@AI_players
                puts "creating ai"
                ai = AIPlayer.new(names.pop, patterns.pop, names[0], patterns[0])
                for obj in @observer_views
                    ai.add_observer(obj)
                end
                @players.push(ai)
            end

            while @players.size < 2 # number of players
                puts "creating real"
                re = RealPlayer.new(names.pop, patterns.pop)
                for obj in @observer_views
                    re.add_observer(obj)
                end
                @players.push(re)
            end
            @board = Board.new(@game.board_width, @game.board_height)
            @player_playing = @players.shuffle[0]
            if @player_playing.is_a? AIPlayer
                self.take_turn(0)
            end
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
            @player_playing.play(@board)
        else
            @board.set_piece(arg, @player_playing.piece)
        end

        p = @player_playing
        w = @board.analyze(@player_playing.pattern_array)
        @player_playing.set_win_status(w)
        puts "#{p.to_s} won status is #{p.won}"
        if w # game over, no need to switch turns
            return
        end
        # switch turns
        @player_playing = @players[@players.index(@player_playing)+1]
        if @player_playing == nil
            @player_playing = @players[0]
        end
        if @player_playing.is_a? AIPlayer
            self.take_turn(0)
        end
        return nil
    end

    def self.get_board()
        return @board
    end

    def self.set_AIs(count)
        @AI_players = count
    end

    def self.handle_event(commands)
        i = Integer(commands[0]) rescue nil
        if commands[0].downcase.include? "new" or
          commands[0].downcase.include? "create"
            if commands[1].downcase.include? "conn"
                self.create_game("Connect4")
            elsif commands[1].downcase.include? "otto"
                self.create_game("OttoToot")
            end
        elsif commands[0].downcase.include? "ai"
            self.set_AIs(Integer(commands[1]))
        elsif commands[0].downcase.include? "restart" or
          commands[0].downcase.include? "reset"
            @players = []
            puts "POOOOOOOOOOOOOOOOOOOOP"
            @board = nil
            @player_playing = nil
        elsif i != nil
            self.take_turn(i)
        else
            puts "#{commands} not recognized."
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

