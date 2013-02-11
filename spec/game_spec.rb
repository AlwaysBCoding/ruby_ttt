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

end
