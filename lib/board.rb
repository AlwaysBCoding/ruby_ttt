class Board

  attr_reader :size, :squares

  def initialize(size=3)
    @size = size
    @squares = initialize_squares(size)
  end

  def mark_square(square_index, marker)
    row, column = translate_index(square_index)
    squares[row][column] = marker
  end

  def value_at(square_index)
    row, column = translate_index(square_index)
    squares[row][column]
  end

  def winner?(mark)
    horizontal_winner?(mark) || vertical_winner?(mark) || first_diagonal_winner?(mark) || second_diagonal_winner?(mark)
  end

  def draw?(player)
    return true if empty_squares.length == 0 && ( !winner?(player.mark) || !winner?(player.opponent.mark) )
  end

  def empty_squares
    @squares.flatten.each_with_index.collect { |sq, i| i+1 if sq == nil}.compact
  end

  def score(player)
    return 1 if winner?(player.mark)
    return -1 if winner?(player.opponent.mark)
    return 0 if draw?(player)
  end

  private

  def first_diagonal_winner?(mark)
    diagonal = []
    size.times do |row|
      diagonal << squares[row][row]
    end
    winner_in_collection?(diagonal, mark)
  end

  def second_diagonal_winner?(mark)
    diagonal = []
    size.times do |row|
      diagonal << squares[row][size - row - 1]
    end
    winner_in_collection?(diagonal, mark)
  end

  def vertical_winner?(mark)
    size.times do |index|
      column = []
      size.times do |row|
        column << squares[row][index]
      end
      return true if winner_in_collection?(column, mark)
    end
    false
  end

  def horizontal_winner?(mark)
    squares.reduce(false) do |winner, row|
      winner || winner_in_collection?(row, mark)
    end
  end

  def winner_in_collection?(collection, mark)
    !collection.include?(nil) && collection.uniq.size == 1 && collection.include?(mark)
  end

  def initialize_squares(size)
    squares = []
    size.times { squares << ([nil]*size) }
    return squares
  end

  def translate_index(square_index)
    square_index -= 1
    row = square_index / size
    column = square_index % size
    return row, column
  end

end
