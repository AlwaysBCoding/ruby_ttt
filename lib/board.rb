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

  def winner?
    horizontal_winner? || vertical_winner? || first_diagonal_winner? || second_diagonal_winner?
  end

  private

  def first_diagonal_winner?
    diagonal = []
    size.times do |row|
      diagonal << squares[row][row]
    end
    winner_in_collection?(diagonal)
  end

  def second_diagonal_winner?
    diagonal = []
    size.times do |row|
      diagonal << squares[row][size - row - 1]
    end
    winner_in_collection?(diagonal)
  end

  def vertical_winner?
    size.times do |index|
      column = []
      size.times do |row|
        column << squares[row][index]
      end
      return true if winner_in_collection?(column)
    end
    false
  end

  def horizontal_winner?
    squares.reduce(false) do |winner, row|
      winner || winner_in_collection?(row)
    end
  end

  def winner_in_collection?(collection)
    !collection.include?(nil) && collection.uniq.size == 1
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
