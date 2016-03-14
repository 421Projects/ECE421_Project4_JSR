require "./game_piece"
require "./game_pattern"
require 'contracts'

class Board

    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants

    invariant(@width) {@width == @original_width}
    invariant(@height) {@height == @original_height}

    Contract Contracts::Nat,Contracts::Nat => Any
	def initialize(width, height)
        @original_width = width
        @original_height = height
		@width = width
		@height = height
		@board = Hash.new
	end

    Contract ArrayOf[GamePattern] => Bool
	def analyze(pattern_array)
		#Looks for all the given patterns in the board
        return false
	end

    Contract Contracts::Nat,Contracts::Nat, GamePiece => nil
	def set_piece(x, y, piece)
		@board[[x,y]] = piece
        return nil
	end

    Contract Contracts::Nat,Contracts::Nat => GamePiece
	def get_piece(x, y)
		return @board[[x, y]]
	end

    Contract None => Pos
    def get_piece_count()
        return 0
    end
end
