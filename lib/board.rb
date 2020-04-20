# frozen_string_literal: true

# Board model
class Board
  SIZE = 10
  TOTAL_CELLS = SIZE * SIZE
  MINE = :x
  FLAG = :f
  HIDDEN = :h
  EMPTY = :e

  attr_accessor :visible, :with_mines

  def initialize
    @visible = Array.new(SIZE) { Array.new(SIZE, HIDDEN) }
    @with_mines = generate_grid_with_mines(@visible)
  end

  def generate_grid_with_mines(nested_array)
    nested_array.map do |array|
      random_number = Random.new.rand(0...9)

      array.each_with_index.map do |_value, key|
        random_number == key ? MINE : HIDDEN
      end
    end
  end
end
