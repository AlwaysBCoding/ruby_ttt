require 'board'

describe Board do
  let(:board) { Board.new }

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

  def mark_squares(board, squares, marker)
    squares.each { |square| board.mark_square(square, marker) }
  end

  context '3x3' do
    let(:board) { Board.new }

    it 'can declare a horizontal winner' do
      board.should_not be_winner
      mark_squares(board, [1,2,3], "Z")
      board.should be_winner
    end

    it 'can declare a horizontal winner on the bottom row' do
      mark_squares(board, [7,8,9], "Q")
      board.should be_winner
    end

    it 'can declare a vertical winner' do
      mark_squares(board, [1,4,7], "Z")
      board.should be_winner
    end

    it 'can declare a topleft-to-bottomright-diagonal winner' do
      mark_squares(board, [1,5,9], "Z")
      board.should be_winner
    end

    it 'can declare a topright-to-bottomleft-diagonal winner' do
      mark_squares(board, [3,5,7], "JDL")
      board.should be_winner
    end
  end

  context '4x4' do
    let(:board) { Board.new(4) }

    it 'can declare a horizontal winner' do
      mark_squares(board, [1,2,3,4], "Z")
      board.should be_winner
    end

    it 'can declare a vertical winner' do
      mark_squares(board, [1,5,9,13], "Z")
      board.should be_winner
    end

    it 'can declare a topleft-to-bottomright-diagonal winner' do
      mark_squares(board, [1,6,11,16], "Z")
      board.should be_winner
    end

    it 'can declare a topright-to-bottomleft-diagonal winner' do
      mark_squares(board, [4,7,10,13], "JDL")
      board.should be_winner
    end
  end

end
