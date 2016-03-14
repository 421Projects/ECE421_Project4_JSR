require "../controller/game_controller"

class CommandLineView

    @@commands = ["new", "print", "place", "quit"]

    def initialize()

    end

    def start_game()
        running = true

        while (running)
            # Player

            #Iterate through the number of real players
            parse_command(get_command())
        end
    end

    def get_command()
        user_input = gets.chomp.split
        parse_command(user_input)
    end

    def parse_command(user_input)

    end

    def place_piece(piece, position)
    end

    def new_game()
        # Get the game mode
        
        # Get the number of real players

        # Get the number of AI Players

        # Initialize the controller
        @game_controller = new GameController()
    end

    def exit_game()
    end

    def print_board()
        # did we decide to implement this?
    end

end

