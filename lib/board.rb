# frozen_string_literal: true

# Board class
class Board
  SIZE = 10
  TOTAL_CELLS = SIZE * SIZE
  MINE = 'x'
  FLAG = 'f'
  HIDDEN = 'h'
  EMPTY = 'e'

  attr_accessor :visible, :with_mines

  def initialize(visible: nil, with_mines: nil)
    @visible = visible || Array.new(SIZE) { Array.new(SIZE, HIDDEN) }
    @with_mines = with_mines || generate_grid_with_mines(@visible)
  end

  def generate_grid_with_mines(nested_array)
    nested_array.map do |array|
      random_number = Random.new.rand(0...9)
      array.map.with_index { |_value, key| random_number == key ? MINE : HIDDEN }
    end
  end
end
