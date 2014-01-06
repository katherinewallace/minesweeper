require './lib/Tile.rb'

class Board
  attr_reader :grid
  BOMB_NUM = 3
  SIZE = [5,5]
  RENDER_SYM = {
    :revealed => '_',
    :unrevealed => '*',
    :exploded => '!',
    :flagged => 'F',
  }

  def initialize(grid = self.class.create_unseeded_grid)
    @grid = grid
    seed_bombs
    set_neighbors
  end

  def to_s #MAKE THIS MORE USEFUL
    "hello, i'm a board"
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

  def tiles
    @grid.flatten
  end

  def set_neighbors
    self.tiles.each do |tile|
      tile.add_neighbors(@grid.flatten)
    end
    @board
  end

  def [](pos)
    # returns a Tile object
    @grid[pos[0]][pos[1]]
  end

  def exploded?
    self.tiles.any? { |tile| tile.status == :exploded }
  end

  def cleared?
    self.tiles.all? { |tile| tile.status == :revealed ||
    tile.bombed == true }
  end

  def render
    @grid.map do |row|
      row.map do |tile|
        neighbor_bombs = tile.neighbor_bomb_count
        if  neighbor_bombs > 0 && tile.status == :revealed
          neighbor_bombs.to_s
        else
          RENDER_SYM[tile.status]
        end
      end
    end
  end

  def display
    rendered = self.render
    render.each do |row|
      row.each do |symbol|
        print symbol + ' '
      end
      puts
    end
    nil
  end

end