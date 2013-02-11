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
		else
			return get_minimax_square(game, turn)
		end
	end

	def get_minimax_scores(game, turn)
		scores = []
		return [game.board.score(self)] if game.over?

		game.empty_squares.each do |move|
			game.mark_square(move, game.send(turn).mark)
			minimax_scores = get_minimax_scores(game, game.switch_turn(turn))

			if game.send(turn) == self
				scores << minimax_scores.min
			elsif game.send(turn) != self
				scores << minimax_scores.max
			end

			game.undo_move(move)
		end
		return scores
	end

	def get_minimax_square(game, turn)
		moves_with_score = {}
		scores = get_minimax_scores(game, turn)

		game.empty_squares.each_with_index do |move, index|
			moves_with_score[move] = scores[index]
		end

		max = moves_with_score.values.max
		return moves_with_score.select { |k,v| v == max }.keys.first
	end

end
