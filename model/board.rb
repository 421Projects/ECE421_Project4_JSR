require 'contracts'
require_relative 'player/player'
class Board

    class ColumnFullError < Exception
    end
    class OutOfBounds < Exception
    end

    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants

    invariant(@width) {@width == @original_width}
    invariant(@height) {@height == @original_height}

    attr_accessor :width, :height, :board

    #Contract Contracts::Nat,Contracts::Nat => Any
	def initialize(width, height)
        @original_width = width
        @original_height = height
		@width = width
		@height = height
		@board = Hash.new(Player.new("*"))
        @piece_count = 0
	end

    Contract ArrayOf[HashOf[[Nat, Nat], String]], Nat, Nat => Bool
	def analyze(pattern_array, p_width, p_height)
		#Looks for all the given patterns in the board

        pattern_array.each { |pattern|

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

    #Contract Contracts::Nat, String  => nil
	def set_piece(column, piece)
        raise OutOfBounds unless column <= @width

        row = 1
        while @board[[row,column]].piece != "*"
            row += 1
        end
        if row >= @height
            raise ColumnFullError
        else
            @board[[row,column]] = piece
            @piece_count += 1
        end

        return nil
	end

    #Contract Contracts::Nat,Contracts::Nat => String
	def get_player_on_pos(row, col)
		return @board[[row, col]]
	end

    #Contract None => Contracts::Nat
    def get_piece_count()
        return 0
    end
end
