class Game

	attr_accessor :player1, :player2, :turn, :board

	def initialize(player1, player2, size=3)
		@player1 = player1
		@player2 = player2
		@turn = :player1
		@board = Board.new(size)
		set_opponents(@player1, @player2)
	end

	def switch_turn(turn)
		@turn = :player2 if turn == :player1
		@turn = :player1 if turn == :player2
		return @turn
	end

	def over?
		return true if winner?(@player1.mark) || winner?(@player2.mark) || empty_squares.count == 0
	end

	private

	def set_opponents(player1, player2)
		player1.opponent = player2
		player2.opponent = player1
	end

	def method_missing(method_name, *args)
		delegated_methods = [:empty_squares, :winner?, :mark_square, :undo_move]
		if delegated_methods.include?(method_name)
			self.board.send(method_name, *args)
		else
			raise NoMethodError.new("Undefined method #{method_name} called on Game")
		end
	end

end
