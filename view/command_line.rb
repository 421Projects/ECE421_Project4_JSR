require_relative "../controller/commandline_controller"
require 'contracts'
require 'observer'

class CommandLineView

    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants

    @@commands = ["new", "print", "place", "quit"]

    attr_accessor :game_started, :running

    Contract None => nil
    def initialize()
        @game_started = false
        @game_finished = false
        @running = false
        return nil
    end

    Contract None => nil
    def start_game()
        CMDController.initialize([self])
        puts "Mode files loaded are:"
        puts CMDController.get_mode_files_loaded
        @running = true

        while (running)
            if CMDController.game_started?
                if CMDController.human_player_playing?
                    puts "#{eval('CMDController.get_player_playings_name')} Next Piece?> "
                    parse_command(get_command())
                elsif CMDController.ai_player_playing?
                    t = Thread.new {
                        CMDController.handle_event(["ai_move"])
                    }
                    print "#{CMDController.get_player_playings_name} Thinking"
                    print "." until t.join(0.25)
                    STDOUT.flush
                end
            else
                puts "Prompt> "
                parse_command(get_command())
            end

        end
    end

    def get_command()
        return gets.chomp.split
    end

    def update(arg)
        if arg.is_a? Player
            puts "#{arg.to_s} has won!"
            #eval("CMDController.handle_event(['reset'])")
            CMDController.handle_event(['reset'])
            @game_started = false
        elsif arg.is_a? Board
            self.pretty_print(arg)
        else
            puts "#{arg} not recognized."
        end
    end

    def parse_command(user_input)
        # http://stackoverflow.com/questions/8258517/how-to-check-whether-a-string-contains-a-substring-in-ruby
        if user_input == nil or user_input[0] == nil
            return
        elsif user_input[0].downcase.include? "help"
            puts " help: \n new: \n restart: \n modes: \n"
        elsif user_input[0].downcase.include? "mode"
            puts "Mode files loaded are:"
            puts CMDController.get_mode_files_loaded
        else
            if user_input[0].downcase.include? "new" or
              user_input[0].downcase.include? "create"
                puts "how many AIs?"
                count = gets.chomp
                user_input << count
            end
            begin
                CMDController.handle_event(user_input)
            rescue CMDController::ModeNotSupported => mns
                puts mns.message
                return
            rescue CMDController::CommandNotSupported => cns
                puts cns.message
                return
            rescue NameError => ne
                puts ne.message
            end
            #eval("CMDController.handle_event(#{user_input})")
        end
    end

    def pretty_print(board)
        puts board.board
        board_pic = ""
        for r in (board.height-1).downto(0)
            for c in 0..(board.width-1)
                # board_pic += "(#{r},#{c})[#{board.get_player_on_pos(r,c).piece}], "
                board_pic += "[#{board.board[[r,c]]}], "
            end
            board_pic += "\n"
        end
        puts board_pic
    end


    Contract None => Contracts::None
    def exit_game()
    end

end

c = CommandLineView.new
c.start_game()
