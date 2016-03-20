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

    #Contract ArrayOf[HashOf[String]] => Bool
	def analyze(pattern_array)
		#Looks for all the given patterns in the board
        return false
	end

    #Contract Contracts::Nat, Player  => nil
	def set_piece(column, player)
        raise OutOfBounds unless column <= @width

        row = 1
        while @board[[row,column]].piece != "*"
            row += 1
        end
        if row >= @height
            raise ColumnFullError
        else
            @board[[row,column]] = player
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
