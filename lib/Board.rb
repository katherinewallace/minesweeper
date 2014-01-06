require './lib/Tile.rb'

class Board
  attr_reader :grid
  BOMB_NUM = 3

  def initialize(grid = self.class.create_unseeded_grid([3,3]))
    @grid = grid
  end

  def self.create_unseeded_grid(size)
    grid = []
    size[0].times do |x_coord|
      grid[x_coord] = []
      size[1].times do |y_coord|
        grid[x_coord] << Tile.new([x_coord, y_coord], [])
      end
    end
    grid
  end

  def seed_bombs(num_bombs)
    until seeeded_bombs == BOARD_NUM
      # seed bombs
    end
  end

  def [](pos)
    # returns a Tile object
    @grid[pos[0]][pos[1]]
  end

  def exploded
    # if any of the tiles have status exploded
  end

  def render
    @grid.map do |row|
      row.map { |tile| tile.bombed } # CHANGE!
    end
  end

  def display
    # print out rendered board
  end

end