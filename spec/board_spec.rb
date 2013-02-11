require 'board'
require 'game'
require 'player'

describe Board do
  let(:board) { Board.new }
  let(:human_player) { Player.new("H", "X")}

  it 'initializes an empty board' do
    board.squares.should == [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
  end

  it 'intiializes with customizable dimensions' do
    board = Board.new(5)
    board.size.should eq 5
    board.squares.length.should eq 5
    board.squares.first.length.should eq 5
  end

  it 'can mark a square with a text value' do
    board.mark_square(4, "Z")
    board.squares[1][0].should eq "Z"
  end

  it 'can read a value from the board' do
    board.mark_square(4, "Z")
    board.value_at(4).should eq "Z"
  end

  it 'can read the empty squares from the board' do
    board.empty_squares.length.should eq 9
    board.mark_square(7,"X")
    board.empty_squares.length.should eq 8
    board.empty_squares.should include(4)
    board.empty_squares.should_not include(7)
  end

  def mark_squares(board, squares, marker)
    squares.each { |square| board.mark_square(square, marker) }
  end

  it 'can undo moves from the board' do
    board = Board.new
    mark_squares(board, [1,2,4], "X")
    board.empty_squares.length.should eq 6
    board.empty_squares.should_not include(2)
    board.undo_move(2)
    board.empty_squares.length.should eq 7
    board.empty_squares.should include(2)
  end

  context '3x3' do
    let(:board) { Board.new }

    it 'can declare a horizontal winner' do
      board.winner?("Z").should be_false
      mark_squares(board, [1,2,3], "Z")
      board.winner?("Z").should be_true
    end

    it 'can declare a horizontal winner on the bottom row' do
      mark_squares(board, [7,8,9], "Q")
      board.winner?("Q").should be_true
    end

    it 'can declare a vertical winner' do
      mark_squares(board, [1,4,7], "Z")
      board.winner?("Z").should be_true
    end

    it 'can declare a topleft-to-bottomright-diagonal winner' do
      mark_squares(board, [1,5,9], "Z")
      board.winner?("Z").should be_true
    end

    it 'can declare a topright-to-bottomleft-diagonal winner' do
      mark_squares(board, [3,5,7], "JDL")
      board.winner?("JDL").should be_true
    end

    context "Completed Game" do
      let(:human_player2) { Player.new("H", "O") }
      let(:game) { Game.new(human_player, human_player2)}

      it 'returns one for a winning game board' do
        mark_squares(board, [1,2,3], "X")
        board.score(human_player).should eq 1
      end

      it 'returns negative one for a losing game board' do
        game.player1.opponent.should eq human_player2
        mark_squares(board, [1,5,9], "O")
        board.score(human_player).should eq -1
      end

      it 'returns zero for a draw' do
        game.player1 = human_player
        mark_squares(board, [2,4,5,7,9], "X")
        mark_squares(board, [1,3,6,8], "O")
        board.score(human_player).should eq 0
      end

    end

  end

  context '4x4' do
    let(:board) { Board.new(4) }

    it 'can declare a horizontal winner' do
      mark_squares(board, [1,2,3,4], "Z")
      board.winner?("Z").should be_true
    end

    it 'can declare a vertical winner' do
      mark_squares(board, [1,5,9,13], "Z")
      board.winner?("Z").should be_true
    end

    it 'can declare a topleft-to-bottomright-diagonal winner' do
      mark_squares(board, [1,6,11,16], "Z")
      board.winner?("Z").should be_true
    end

    it 'can declare a topright-to-bottomleft-diagonal winner' do
      mark_squares(board, [4,7,10,13], "JDL")
      board.winner?("JDL").should be_true
    end
  end

end
