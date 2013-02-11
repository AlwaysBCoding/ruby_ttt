require 'game'
require 'player'
require 'board'

describe Game do
	let(:player1) { Player.new("H", "X")}
	let(:player2) { Player.new("H", "O")}

	let(:game) { Game.new(player1, player2) }

	it 'Is initialized with the turn of player1' do
		game.turn.should eq :player1
	end

	it 'Can switch turns' do
		game.switch_turn(game.turn)
		game.turn.should eq :player2
	end

	it 'delegates empty_squares to board' do
		squares = game.empty_squares
		squares.count.should eq 9
	end

	def mark_squares(board, squares, marker)
    squares.each { |square| board.mark_square(square, marker) }
  end

	it 'knows when a game is over' do
		game.should_not be_over
		mark_squares(game.board, [1,2,3], "X")
		game.should be_over
		game = Game.new(player1, player2)
		mark_squares(game.board, [1,3], "X")
		game.should_not be_over
		mark_squares(game.board, [2,5,8], "O")
		game.should be_over
		game = Game.new(player1, player2)
    mark_squares(game.board, [2,4,5,7,9], "X")
    game.should_not be_over
    mark_squares(game.board, [1,3,6,8], "O")
    game.should be_over
	end

end
