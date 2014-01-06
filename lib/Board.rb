require './lib/Tile.rb'

class Board
  attr_reader :grid
  BOMB_NUM = 3
  SIZE = [3,3]

  def initialize(grid = self.class.create_unseeded_grid)
    @grid = grid
    seed_bombs
    p self.render
  end

  def self.create_unseeded_grid
    grid = []
    SIZE[0].times do |x_coord|
      grid[x_coord] = []
      SIZE[1].times do |y_coord|
        grid[x_coord] << Tile.new([x_coord, y_coord], [])
      end
    end
    grid
  end

  def seed_bombs
    seeded_bombs = 0
    until seeded_bombs == BOMB_NUM
      x_coord = rand(0...SIZE[0])
      y_coord = rand(0...SIZE[1])
      tile = self[[x_coord, y_coord]]
      unless tile.bombed
        tile.bombed = true
        seeded_bombs += 1
      end
    end
    @grid = grid
  end


  def [](pos)
    # returns a Tile object
    @grid[pos[0]][pos[1]]
  end

  def exploded?
    @grid.any? do |row|
      row.any? { |tile| tile.status == :exploded }
    end
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