require_relative "../model/board"
require_relative "../model/player/ai_player"
require_relative "../model/player/real_player"
require_relative "../model/game/game"
require 'contracts'
require 'observer'

class CMDController

    include Observable
    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants

    class CommandNotSupported < StandardError
    end
    class ModeNotSupported < StandardError
    end
    class AICountError < StandardError
    end

    Contract ArrayOf[Object] => Any
    def self.initialize(observer_views)
        original_dir = Dir.pwd
        Dir.chdir(__dir__)

        classes_before = ObjectSpace.each_object(Class).to_a
        Dir["../model/game/*"].each {|file|
            require_relative file
        }
        Dir.chdir(original_dir)

        classes_after = ObjectSpace.each_object(Class).to_a
        @modes_loaded = classes_after - classes_before

        @game_started = false
        @observer_views = observer_views.to_a
        @players = []
        @board = nil
        @player_playing = nil
        @AI_players = 0
    end

    Contract None => ArrayOf[Class]
    def self.get_mode_files_loaded
        @modes_loaded
    end

    Contract None => String
    def self.get_player_playings_name
        return @player_playing.to_s
    end

    Contract None => Bool
    def self.human_player_playing?
        return @player_playing.is_a? RealPlayer
    end

    Contract None => Bool
    def self.ai_player_playing?
        return @player_playing.is_a? AIPlayer
    end

    Contract None => Bool
    def self.game_started?
        @game_started
    end

    Contract String, Maybe[Integer] => Game
    def self.create_game(game, ai_players=0)
        c = self.new
        for obj in @observer_views
            c.add_observer(obj)
        end
        if ai_players.to_i.to_s == ai_players.to_s and
          ai_players.to_i >= 0 and
          ai_players.to_i <= 2
            @AI_players = ai_players
        else
            raise AICountError, "Only two AIs supported."
        end
        begin
            gameClazz = Object.const_get(game) # Game
        rescue StandardError
            raise ModeNotSupported
        end
        if gameClazz.superclass == Game
            @game = gameClazz.new()
            @game_started = true
            #patterns = [@game.p1_patterns, @game.p2_patterns]
            #names = [@game.p1_piece, @game.p2_piece]
            patterns = @game.patterns
            names = @game.pieces
            for i in 0..(@AI_players-1)
                if @players.size < @game.num_of_players and
                   @players.size <= 2
                    ai = AIPlayer.new(names[i], patterns[i],
                                      names[i+1] || names[0], patterns[i+1] || patterns[0])
                    @player_playing = ai
                    for obj in @observer_views
                        ai.add_observer(obj)
                    end
                    @players.push(ai)
                end
            end

            while @players.size < @game.num_of_players #2 # number of players
                re = RealPlayer.new(names.pop, patterns.pop)
                for obj in @observer_views
                    re.add_observer(obj)
                end
                @players.push(re)
            end

            @board = Board.new(@game.board_width, @game.board_height)
            for obj in @observer_views
                @board.add_observer(obj)
            end

            if @player_playing == nil
                @player_playing = @players.shuffle[0]
            end
        else
            raise StandardError, "#{gameClazz} not a Game."
        end
        return @game
    end

    Contract Maybe[Nat] => nil
    def self.take_turn(arg)
        if arg == nil
            return arg
        end
        if @player_playing.is_a? AIPlayer
            @player_playing.play(@board)
        else
            @board.set_piece(arg, @player_playing.piece)
        end

        if @board.analyze(@player_playing.pattern_array)
            # game over, no need to switch turns
            @player_playing.set_win_status(true)
        else # switch turns
            @player_playing = @players[@players.index(@player_playing)+1]
            if @player_playing == nil
                @player_playing = @players[0]
            end
            # if @player_playing.is_a? AIPlayer
            #     self.take_turn(0)
            # end
        end
        nil
    end

    Contract None => Board
    def self.get_board()
        return @board
    end

    Contract Nat => nil
    def self.set_AIs(count)
        @AI_players = count
        nil
    end

    Contract ArrayOf[String] => nil
    def self.handle_event(commands)
        case commands
        when Array
            if commands[0].respond_to?("to_i") and
              commands[0].to_i.to_s == commands[0] and
              @game_started
                self.take_turn(Integer(commands[0]))
            elsif commands[0].respond_to?("downcase")
                if commands[0].downcase.include? "new" or
                  commands[0].downcase.include? "create"
                    ai_count = Integer(commands[2]) rescue nil
                    begin
                        gameClazz = Object.const_get(commands[1]) # Game
                    rescue NameError => ne
                        raise ne, "#{commands[1]} mode not found."
                    end
                    if gameClazz.superclass == Game
                        self.create_game(commands[1], ai_count)
                    else
                        raise ModeNotSupported,"#{commands[1]} mode not supported."
                    end
                elsif commands[0].downcase.include? "restart" or
                     commands[0].downcase.include? "reset"
                    @players = []
                    @board = nil
                    @player_playing = nil
                    @game_started = false
                elsif commands[0].downcase.include? "ai"
                    self.take_turn(0)
                else
                    raise CommandNotSupported, "#{commands} not supported."
                end
            else
                raise CommandNotSupported, "#{commands} not supported."
            end
        else
            raise CommandNotSupported, "#{commands} not supported."
        end
        nil
    end

end
