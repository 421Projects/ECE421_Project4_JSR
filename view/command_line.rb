require "../controller/commandline_controller"
require 'contracts'

class CommandLineView

    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants

    @@commands = ["new", "print", "place", "quit"]

    Contract None => nil
    def initialize()
        @game_started = false
        return nil
    end

    Contract None => nil
    def start_game()
        eval("CMDController.initialize")
        running = true

        while (running)
            if @game_started
                puts "#{eval('CMDController.get_player_playing.to_s')}> "
            else
                puts "Prompt> "
            end
            # Player

            #Iterate through the number of real players
            parse_command(get_command())
        end
    end

    def get_command()
        return gets.chomp.split
    end

    def parse_command(user_input)
        # http://stackoverflow.com/questions/8258517/how-to-check-whether-a-string-contains-a-substring-in-ruby
        if user_input[0].include? "print"
            pretty_print(eval("CMDController.get_board"))
        elsif user_input[0].downcase.include? "help"
            puts " help: \n new: \n restart: \n"
        else
            if user_input[0].downcase.include? "new" or
              user_input[0].downcase.include? "create"
                @game_started = true
            elsif user_input[0].downcase.include? "reset" or
                 user_input[0].downcase.include? "restart"
                @game_started = false
            end
            eval("CMDController.handle_event(#{user_input})")
        end
    end

    def pretty_print(board)
        puts board.board
        board_pic = ""
        for r in board.height.downto(1)
            for c in 1..board.width
                # board_pic += "(#{r},#{c})[#{board.get_player_on_pos(r,c).piece}], "
                board_pic += "[#{board.get_player_on_pos(r,c).piece}], "
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
