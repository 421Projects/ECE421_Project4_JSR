require 'contracts'
require 'observer'
require_relative 'player/player'
class Board

    include Observable
    #http://blog.honeybadger.io/ruby-custom-exceptions/
    class ColumnFullError < StandardError
    end
    class OutOfBounds < StandardError
    end

    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants

    invariant(@width) {@width == @original_width}
    invariant(@height) {@height == @original_height}

    attr_reader :piece_count, :height, :width
    attr_accessor :board

    Contract Contracts::Nat,Contracts::Nat => Any
	def initialize(width, height)
        @original_width = width
        @original_height = height
		@width = width
		@height = height
		@board = Hash.new("*")
        @piece_count = 0
	end

    Contract None => Board
    def copy()
        new_board = Board.new(@width, @height)
        new_board.board = @board.clone
        return new_board
    end

    Contract ArrayOf[HashOf[[Nat, Nat], String]] => Bool
	def analyze(pattern_array)
		#Looks for all the given patterns in the board                

        pattern_array.each { |pattern|

            p_width = 0
            p_height = 0
            # Find the width and height of the pattern
            pattern.each { |key, value|
                if key[0] >= p_height then
                    p_height = key[0] + 1
                end

                if key[1] >= p_width then
                    p_width = key[1] + 1
                end
            }

            for row in 0..@height - p_height
                for column in 0..@width - p_width
                    # Verify the spot has all the pieces matching with the pattern
                    if find(pattern, row, column)
                        return true
                    end

                    column = column + 1
                end
            end
            
        }
        

        return false
	end

    # The row and the column are the top left of the area were the pattern is overlaid on the board.
    Contract HashOf[[Nat, Nat], String], Nat, Nat => Bool
    def find(pattern, row, column)
        
        pattern.each { |key, value|
            board_value = @board[[row + key[0], column + key[1]]]
            if board_value != value
                return false
            end
        }

        return true
    end

    Contract Contracts::Nat, String => nil
	def set_piece(column, piece)
        raise OutOfBounds unless column <= @width

        row = 0
        while @board[[row,column]] != "*"
            row += 1
        end
        if row >= @height
            raise ColumnFullError
        else
            @board[[row,column]] = piece
            @piece_count += 1
            changed
            notify_observers(self)
        end

        return nil
	end

    Contract Nat, Nat => String
	def get_player_on_pos(row, col)
		return @board[[row, col]]
	end
end
