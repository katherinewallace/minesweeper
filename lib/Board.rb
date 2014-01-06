require './lib/Tile.rb'

class Board
  attr_reader :grid

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

  def self.seed_bombs(num_bombs)

  end

  def [](pos)
    # accesses Tile by coordinates
  end

  def render
    @grid.map do |row|
      row.map { |tile| tile.status }
    end
  end

  def display
    # print out rendered board
  end

end