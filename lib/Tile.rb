class Tile
  attr_reader :status, :coordinates, :neighbors
  attr_accessor :bombed

  def initialize (coordinates, neighbors, status = :unrevealed, bombed = :false)
    @status = status
    @bombed = false
    @coordinates = coordinates
    @neighbors = neighbors
  end

  def reveal
    unless self.bombed
      @status = :revealed
    else
      @status = :exploded
    end
  end

  def add_neighbor(other_tile)
    @neighbors << other_tile
  end

  def neighbor_bomb_count
    count = 0
    @neighbors.each do |neighbor|
      count += 1 if neighbor.status == :bombed
    end
    count
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