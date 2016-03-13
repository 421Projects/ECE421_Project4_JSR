require "./game_piece"
require "./game_pattern"

class Board

	def initialize(width, height)
		@width = width
		@height = height
		@board = Hash.new
	end

	def analyze(pattern_array)
		#Looks for all the given patterns in the board
	end

	def set_piece(x, y, piece)
		@board[[x,y]] = piece
	end

	def get_piece(x, y)
		return @board[[x, y]]
	end
end