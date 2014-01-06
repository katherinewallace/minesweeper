class Minesweeper

  def initialize
    @board = Board.new()

  end

  def run
    @board.display
    until @board.exploded? || @board.cleared?
      puts "Enter your move:"
      user_input = gets.chomp
      handle_input(user_input)
      @board.display
    end
    if @board.exploded?
      puts "You're dead!"
    else
      puts "You win!"
    end
  end

  def handle_input(user_input)
    input = user_input.split(" ")
    pos = [input[1].to_i, input[2].to_i]
    if input[0] == "r"
      @board.explore(pos)
    elsif input[0] = "f"
      @board.flag(pos)
    else
      puts "Invalid input"
    end
  end

end