#!/usr/bin/env ruby

require 'yaml'
require './lib/Board.rb'

class Minesweeper

  def initialize(board=nil)
    board.nil? ? @board = Board.new() : @board = board
  end

  def run
    @board.display
    until @board.exploded? || @board.cleared?
      puts "Enter your move:"
      user_input = gets.chomp
      if user_input == 'q'
        save_game
        return
      end
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

  def save_game
    puts "Enter a file name:"
    file_name = "./saves/#{gets.chomp}.yml"
    File.open(file_name, "w") { |f| f.puts @board.to_yaml }
  end

end

if __FILE__ == $PROGRAM_NAME
  if ARGV.empty?
    g = Minesweeper.new()
    g.run
  else
    file_name = "./saves/#{ARGV.pop}.yml"
    board = YAML.load_file(file_name)
    g = Minesweeper.new(board)
    g.run
  end
end