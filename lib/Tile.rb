class Tile
  attr_reader :status, :coordinates
  attr_accessor :bombed, :neighbors

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

  def neighbor_bomb_count
    count = 0
    @neighbors.each do |neighbor|
      count += 1 if neighbor.status == :bombed
    end
    count
  end

end