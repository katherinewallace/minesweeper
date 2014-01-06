require 'debugger'

class Tile
  attr_reader :status, :coordinates, :neighbors # REMOVE!!!
  attr_accessor :bombed

  def initialize (coordinates, neighbors, status = :unrevealed, bombed = :false)
    @status = status
    @bombed = false
    @coordinates = coordinates
    @neighbors = neighbors
  end

  def to_s
    String({
      :coordinates => @coordinates,
      :status => @status,
      :bombed => @bombed
      })
  end

  def reveal
    unless self.bombed
      @status = :revealed
    else
      @status = :exploded
    end
  end

  def flag
    @status = :flagged if @status == :unrevealed
    @status = :unrevealed if @status == :flagged
  end

  def neighbor_bomb_count
    # debugger #REMOVE
    count = 0
    @neighbors.each do |neighbor|
      count += 1 if neighbor.bombed == true
    end
    count
  end

  def add_neighbors(other_tiles)
    other_tiles.each do |other_tile|
      next if other_tile == self
      @neighbors << other_tile if adjacent?(other_tile)
    end
    nil
  end

  private

  def adjacent?(other_tile)
    adjacent_coord(self.coordinates[0], other_tile.coordinates[0]) &&
    adjacent_coord(self.coordinates[1], other_tile.coordinates[1])
  end

  def adjacent_coord(coord1, coord2)
    coord1 == coord2 + 1 || coord2 == coord1 + 1 || coord1 == coord2
  end

end