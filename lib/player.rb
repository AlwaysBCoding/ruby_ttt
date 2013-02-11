class Player

	attr_accessor :species, :mark, :opponent

	def initialize(species, mark="X")
		@species = "human" if species == "H"
		@species = "computer" if species == "C"
		@mark = mark
	end

	def mark_square(board, square)
		board.mark_square(square, @mark)
	end

	def minimax(game, turn)
		if game.empty_squares.count == 9
			return 1
		elsif game.empty_squares.count == 8
			return 5 if game.empty_squares.include?(5)
			return 1 if !game.empty_squares.include?(5)
		end
	end

end
