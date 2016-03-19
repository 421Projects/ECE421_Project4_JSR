require "../controller/commandline_controller"
require 'contracts'

class CommandLineView

    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants

    @@commands = ["new", "print", "place", "quit"]

    Contract None => nil
    def initialize()

    end

    Contract None => nil
    def start_game()
        eval("g = CMDController.new")
        running = true

        while (running)
            # Player

            #Iterate through the number of real players
            parse_command(get_command())
        end
    end

    def get_command()
        return gets.chomp.split
    end

    def parse_command(user_input)
        eval("g.#{user_input}")
    end

    def place_piece(piece, position)
    end

    Contract String => GameMode
    def new_game(game)
        # Get the game mode

        # Get the number of real players

        # Get the number of AI Players

        # Initialize the controller
        @game_controller = new GameController()
    end

    Contract None => Contracts::None
    def exit_game()
    end

    def print_board()
        # did we decide to implement this?
    end

end

c = CommandLineView.new
c.start_game()
