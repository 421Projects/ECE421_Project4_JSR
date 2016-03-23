require_relative "../model/board"
require_relative "../model/player/ai_player"
require_relative "../model/player/real_player"
require_relative "../model/game/game"
require 'contracts'
require 'gtk3'
require 'observer'

class GameController

    include Observable
    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants
    
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

    #Contract Class, Maybe[Integer] => Game
    def self.create_game(game, ai_players=0)
        c = self.new
        for obj in @observer_views
            c.add_observer(obj)
        end
        if ai_players.is_a? Numeric
            @AI_players = ai_players
        else
            @AI_players = 0
        end
        gameClazz = game
        if gameClazz.superclass == Game
            @game = gameClazz.new()
            @game_started = true
            #patterns = [@game.p1_patterns, @game.p2_patterns]
            #names = [@game.p1_piece, @game.p2_piece]
            patterns = @game.patterns
            names = @game.pieces
            if @game.ai_compatible?
                for i in 0..(@AI_players-1)
                    if @players.size < @game.num_of_players
                        ai = AIPlayer.new(names[i], patterns[i],
                                          names[i+1] || names[0], patterns[i+1] || patterns[0])
                        @player_playing = ai
                        for obj in @observer_views
                            ai.add_observer(obj)
                        end
                        @players.push(ai)
                    end
                end
            else
                c.changed
                c.notify_observers(@game)
            end

            while @players.size < @game.num_of_players#2 # number of players
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
        # if @player_playing.is_a? AIPlayer
        #     self.take_turn(0)
        # end
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

    def self.get_board()
        return @board
    end

    def self.set_AIs(count)
        @AI_players = count
    end

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
                end
            else
                raise CommandNotSupported, "#{commands} not supported."
            end
        else
            raise CommandNotSupported, "#{commands} not supported."
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


    
    
    
    
    
    
    
    
    
    
    def self.onclick_dialog_button_start_game(game_title, player1_status, player2_status, player3_status, player4_status)
        get_game_class_from_title(game_title)
    end
    
    def self.onclick_dialog_combobox_gamemodes(game_name)
        return if game_name.nil?
        num_of_players = get_game_class_from_title(game_name).new.num_of_players

        combobox = Gtk::ComboBoxText.new.append_text("Real").append_text("AI")
        widgets = []
        num_of_players.times do |i|
            widgets.push(Gtk::Label.new.set_text("Player #{i+1}"))
            widgets.push(combobox)
        end
        
        return widgets
    end
    
    def self.find_subclasses(class_name)
        # Source: http://stackoverflow.com/questions/2393697/look-up-all-descendants-of-a-class-in-ruby
        superclass = Object.const_get(class_name)
        ObjectSpace.each_object(Class).select { |klass| klass < superclass; }
    end
    
    def self.get_game_class_from_title(title)
        return if title.nil?
        game_classes.each {|game_class| return game_class if game_class.new.title == title}
    end
    
    def self.game_classes
        find_subclasses("Game")
    end
    
    def self.game_modes
        find_subclasses("Game").map {|game_mode| game_mode.new.title}
    end
end

