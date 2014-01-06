class Tile
  attr_reader :status, :coordinates

  def initialize (status = :unrevealed, coordinates)
    @status = status
    @coordinates = coordinates
  end

  def reveal
    if @status = :bombed
      @status = :exploded
    elsif @status = :unrevealed
      @status = :revealed
    end
    @status
  end



end