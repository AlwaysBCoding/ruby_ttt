require 'board'
require 'player'

describe Player do
	let(:board) { Board.new }
	let(:human_player) { Player.new("H", "X") }
	let(:computer_player) { Player.new("C", "O") }

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

	end

end
