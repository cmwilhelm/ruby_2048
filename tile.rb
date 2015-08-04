# Represents a numerical tile on the gameboard.
# Should have a value equal to powers of 2 >= 2^1.

class Tile
  
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def to_s
    "Tile, value=#{@value}"
  end

end
