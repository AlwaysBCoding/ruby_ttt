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

end
