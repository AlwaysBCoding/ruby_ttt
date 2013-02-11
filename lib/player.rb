class Player

	attr_accessor :species, :mark

	def initialize(species, mark)
		@species = "human" if species == "H"
		@species = "computer" if species == "C"
		@mark = mark
	end

	def mark_square(board, square)
		board.mark_square(square, @mark)
	end

end
