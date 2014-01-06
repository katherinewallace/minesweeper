class Minesweeper

  def initialize
    @board = Board.new()

  end

  def run
    until @board.exploded? || @board.cleared?
      # get user input
    end
  end

end