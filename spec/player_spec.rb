require 'board'
require 'player'

describe Player do
	let(:board) { Board.new }
	let(:human_player) { Player.new("H", "X") }
	let(:computer_player) { Player.new("C", "O") }
	let(:game) { Game.new(human_player, computer_player) }

	it 'can be of type Human or Computer' do
		human_player.species.should eq "human"
		computer_player.species.should eq "computer"
	end

	it 'is initializes with a custom mark' do
		human_player.mark.should eq "X"
		computer_player.mark.should eq "O"
	end

	it 'can mark a square on a board' do
		human_player.mark_square(board, 3)
		board.value_at(3).should eq human_player.mark
	end

	describe "#minimax" do
		def mark_squares(board, squares, marker)
	    squares.each { |square| board.mark_square(square, marker) }
	  end

	  it 'returns the top left square for the game move 1' do
	  	square = computer_player.minimax(game, :player2)
	  	square.should eq 1
	  end

	  it 'returns the middle square for game move 2' do
	  	game = Game.new(human_player, computer_player)
	  	mark_squares(game.board, [1], "O")
	  	square = computer_player.minimax(game, :player2)
	  	square.should eq 5
	  end

	end

end
