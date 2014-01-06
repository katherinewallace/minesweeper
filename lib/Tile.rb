require 'debugger'

class Tile
  attr_reader :status, :coordinates, :neighbors # REMOVE
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
    return if self.status == revealed
    @status = self.bombed ? :exploded : :revealed
    return if status == :exploded
    if neighbor_bomb_count == 0
      @neighbors.each do |neighbor|
        next if neighbor.bombed
        neighbor.reveal
      end
    end
    nil
  end

  def flag
    if @status == :flagged
      @status = :unrevealed
    elsif @status == :unrevealed
      @status = :flagged
    end
  end

  def neighbor_bomb_count
    @neighbors.inject(0) do |accum, neighbor|
      neighbor.bombed ? accum + 1 : accum
    end
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