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
        
        @grid_game_board = @builder.get_object("grid_game_board")
        
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
            GameController.create_game(GameController.get_game_class_from_title(@dialog_combobox_gamemodes.active_text))
           
            board = GameController.get_board
            
        }
        
        @button_new_game = @builder.get_object("button_new_game")
        @button_new_game.signal_connect("clicked") { @dialog.run }
        



        image = Gtk::Image::new
        image.set_from_file("../assets/Tile_Red.png")
        image.set_visible(true)
        image.set_focus(false)
        
        label = @builder.get_object("label_current_player")
        label.set_text("asd")
        
        grid = @builder.get_object("grid_game_board")
        #grid.attach(image, 7, 7, 1, 1)
        tile = grid.get_child_at(3, 3)
        tile.destroy

        combobox = Gtk::ComboBoxText.new
        combobox.append_text("Asd")
        combobox.append_text("Aassd")
        combobox.show()
        grid.attach(combobox, 3, 3, 1, 1)

        
        #image.set_from_file("../assets/Tile_Red.png")
        #grid.attach(image, 8, 7, 1, 1)
                
        
        Gtk.main()
    end
    
    Contract Or[Player, Board, Game] => nil
    def update(arg)
        if arg.is_a? Player
            puts "#{arg.to_s} has won!"
            #eval("CMDController.handle_event(['reset'])")
            CMDController.handle_event(['reset'])
        elsif arg.is_a? Board
            self.pretty_print(arg)
        elsif arg.is_a? Game
            puts "#{arg} is not AI compatible.\n" +
                 "Creating all players as human players."
        else
            puts "#{arg} not recognized."
        end
        nil
    end 
end

app = GameBoardView.new
