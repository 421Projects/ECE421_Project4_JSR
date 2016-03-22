Thread.abort_on_exception = true

require 'gtk3'
require_relative "../controller/game_controller"

class App
    def initialize
    
        
    
        Gtk.init
        @builder = Gtk::Builder::new
        @builder.add_from_file("ui.glade")
        
        window = @builder.get_object("window_main")
        window.signal_connect("destroy") { Gtk.main_quit }
        window.show()
        
        dialog = @builder.get_object("dialog1")
        dialog.signal_connect("destroy") { Gtk.main_quit }
        dialog.show()

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
    
    def factorial(number)
        (1..number).inject(:*) || 1
    end
    
    def on_button_calculate
        f = factorial(@entry_number.text.to_i)
        @entry_factorial.set_text(f.to_s)
    end
    
    def on_button_start
        start = @entry_start.text.to_f
        stop = @entry_end.text.to_f
        step = (stop - start) / 10000
        start = 0
        
        while start <= 1.00 do
            @progressbar.fraction = start
            start += step
            puts start
            sleep 0.1
        end
    end    
end

app = App.new
