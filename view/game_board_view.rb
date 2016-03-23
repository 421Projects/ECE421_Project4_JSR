Thread.abort_on_exception = true

require 'contracts'
require 'gtk3'
require 'observer'
require_relative "../controller/game_controller"

class GameBoardView

    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants

    def initialize

        GameController.initialize([self])
    
        Gtk.init
        @builder = Gtk::Builder::new
        @builder.add_from_file("game_board_view.glade")
        
        @window_main = @builder.get_object("window_main")
        @window_main.set_title("Connect!")
        @window_main.signal_connect("destroy") { Gtk.main_quit }
        @window_main.show
        
        @image_tile_empty = Gtk::Image::new.set_from_file("../assets/Tile_Empty.png").set_visible(true).set_focus(false)
        @image_tile_black = Gtk::Image::new.set_from_file("../assets/Tile_Black.png").set_visible(true).set_focus(false)
        @image_tile_red = Gtk::Image::new.set_from_file("../assets/Tile_Red.png").set_visible(true).set_focus(false)
        @image_tile_green = Gtk::Image::new.set_from_file("../assets/Tile_Green.png").set_visible(true).set_focus(false)
        @image_tile_pink = Gtk::Image::new.set_from_file("../assets/Tile_Pink.png").set_visible(true).set_focus(false)
        
        @grid_game_board = @builder.get_object("grid_game_board")
        @grid_play_buttons = @builder.get_object("grid_play_buttons")
        
        @dialog = @builder.get_object("dialog_new_game")
        @dialog.set_title("New Game")
        @dialog.signal_connect("response") { @dialog.hide }

        @dialog_grid_dynamic = @builder.get_object("dialog_grid_dynamic")
        
        @dialog_combobox_gamemodes = @builder.get_object("dialog_combobox_gamemodes")
        GameController.game_modes.each {|game_mode| @dialog_combobox_gamemodes.append_text(game_mode)}
        
        @dialog_combobox_player1 = @builder.get_object("dialog_combobox_player1")
        @dialog_combobox_player2 = @builder.get_object("dialog_combobox_player2")
        @dialog_combobox_player3 = @builder.get_object("dialog_combobox_player3")
        @dialog_combobox_player4 = @builder.get_object("dialog_combobox_player4")
        
        @dialog_button_start_game = @builder.get_object("dialog_button_start_game")
        @dialog_button_start_game.signal_connect("clicked") { 
            GameController.onclick_dialog_button_start_game(@dialog_combobox_gamemodes.active_text,
                                                         @dialog_combobox_player1.active_text,
                                                         @dialog_combobox_player2.active_text,
                                                         @dialog_combobox_player3.active_text,
                                                         @dialog_combobox_player4.active_text)

            if (@dialog_combobox_player1.active_text == "AI" && @dialog_combobox_player2.active_text == "AI")
                GameController.create_game(GameController.get_game_class_from_title(@dialog_combobox_gamemodes.active_text), 2)
            elsif (@dialog_combobox_player1.active_text == "AI" || @dialog_combobox_player2.active_text == "AI")
                GameController.create_game(GameController.get_game_class_from_title(@dialog_combobox_gamemodes.active_text), 1)
            else
                GameController.create_game(GameController.get_game_class_from_title(@dialog_combobox_gamemodes.active_text))
            end            
           
            clear_board
        }
        
        @button_new_game = @builder.get_object("button_new_game")
        @button_new_game.signal_connect("clicked") { @dialog.run }               
        
        Gtk.main()
    end
    
    Contract Or[Player, Board, Game] => nil
    def update(arg)
        if arg.is_a? Player
            puts "#{arg.to_s} has won!"
            clear_board
        elsif arg.is_a? Board
            
            # Clear the board.
            15.times do |i|
                15.times do |j|
                    tile = @grid_game_board.get_child_at(i, j)
                    tile.destroy unless tile.nil?
                end
            end
            
            # Recreate the board.
            board = GameController.get_board
            board.width.times do |i|
                board.height.times do |j|
                    player = board.get_player_on_pos(j, i)
                    image = Gtk::Image::new.set_from_file("../assets/Tile_Empty.png").set_visible(true).set_focus(false) if player == "*"
                    image = Gtk::Image::new.set_from_file("../assets/Tile_Red.png").set_visible(true).set_focus(false) if player == "R"
                    image = Gtk::Image::new.set_from_file("../assets/Tile_Black.png").set_visible(true).set_focus(false) if player == "B"
                    image = Gtk::Image::new.set_from_file("../assets/Tile_Green.png").set_visible(true).set_focus(false) if player == "G"
                    image = Gtk::Image::new.set_from_file("../assets/Tile_Pink.png").set_visible(true).set_focus(false) if player == "P"
                    @grid_game_board.attach(image, i, board.height-j, 1, 1)
                end
            end
                        
        elsif arg.is_a? Game
            puts "#{arg} is not AI compatible.\n" +
                 "Creating all players as human players."
        else
            puts "#{arg} not recognized."
        end
        nil
    end 
    
    def clear_board
        board = GameController.get_board
    
        # Clear the board.
        15.times do |i|
            15.times do |j|
                tile = @grid_game_board.get_child_at(i, j)
                tile.destroy unless tile.nil?
            end
        end
        
        # Clear the "Place" buttons.
        15.times do |i|
            tile = @grid_play_buttons.get_child_at(i, 0)
            tile.destroy unless tile.nil?
        end
        
        # Recreate the board.
        board.width.times do |i|
            board.height.times do |j|
                image = Gtk::Image::new.set_from_file("../assets/Tile_Empty.png").set_visible(true).set_focus(false)
                @grid_game_board.attach(image, i, j, 1, 1)
            end
        end
        
        # Add the "Place" buttons.
        board.width.times do |i|
            button = Gtk::Button::new.set_label("Place").set_visible(true).set_focus(false)
            button.signal_connect("clicked") {GameController.take_turn(i)}
            @grid_play_buttons.attach(button, i, 0, 1, 1)
        end
    end
end

app = GameBoardView.new
