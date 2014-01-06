class Tile
  attr_reader :status, :coordinates, :neighbors

  def initialize (coordinates, neighbors, status = :unrevealed)
    @status = status
    @coordinates = coordinates
    @neighbors = neighbors
  end

  def reveal
    if @status == :bombed
      @status = :exploded
    elsif @status == :unrevealed
      @status = :revealed
    end
    @status
  end

  def neighbor_bomb_count
    count = 0
    @neighbors.each do |neighbor|
      count += 1 if neighbor.status == :bombed
    end
    count
  end

end