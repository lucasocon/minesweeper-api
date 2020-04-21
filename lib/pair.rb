# frozen_string_literal: true

# Pair class
class Pair
  attr_accessor :x, :y

  def initialize(coord_x:, coord_y:)
    @x = coord_x
    @y = coord_y
  end
end
