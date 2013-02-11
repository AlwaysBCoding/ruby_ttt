class Game

	attr_accessor :player1, :player2

	def initialize(player1, player2)
		@player1 = player1
		@player2 = player2
		set_opponents(@player1, @player2)
	end

	private

	def set_opponents(player1, player2)
		player1.opponent = player2
		player2.opponent = player1
	end

end
