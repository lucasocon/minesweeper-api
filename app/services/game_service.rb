# frozen_string_literal: true

# GameService service
class GameService < ApplicationService
  attr_reader :attempt

  def initialize(game, coord_x, coord_y)
    @game = game
    @board = Board.new(visible: game.board, with_mines: game.mines_board)
    @attempt = Pair.new(coord_x: coord_x.to_i - 1, coord_y: coord_y.to_i - 1)
    @empty_cells = []
  end

  def call
    if @game.lost?
      message = 'Sorry, the game is over, please try again.'
    else
      reveal_attempt(@attempt, @board.visible)
      @game.update(board: @board.visible)
      @game.update(lost: true) if a_mine?(@attempt)
      @game.update(won: true) if win?

      message = if a_mine?(@attempt)
                  'Game Over'
                elsif win?
                  'You Win'
                else
                  'Next Movement'
                end
    end

    OpenStruct.new(message: message, game: @game)
  end

  private

  def a_mine?(cell)
    @board.with_mines[cell.y][cell.x] == Board::MINE
  end

  def win?
    @board.visible.flatten.count(Board::HIDDEN) == @board.with_mines.flatten.count(Board::MINE)
  end

  def reveal_attempt(cell, board)
    number = number_of_surrounding_mines(cell)

    if a_mine?(cell)
      board[cell.y][cell.x] = Board::MINE
    elsif number.zero?
      board[cell.y][cell.x] = Board::EMPTY
      @empty_cells << cell

      show_empty_adjacent_cells(cell)
    else
      board[cell.y][cell.x] = number
    end
  end

  def surrounding_cells(coordinates)
    surrounding_cells = []

    # check if that has cells above
    surrounding_cells << Pair.new(coord_x: coordinates.x, coord_y: coordinates.y + 1) if coordinates.y < Board::SIZE - 1

    # check if that has cells below
    surrounding_cells << Pair.new(coord_x: coordinates.x, coord_y: coordinates.y - 1) if coordinates.y.positive?

    # check if that has cells at left
    surrounding_cells << Pair.new(coord_x: coordinates.x - 1, coord_y: coordinates.y) if coordinates.x.positive?

    # check if that has cells at right
    surrounding_cells << Pair.new(coord_x: coordinates.x + 1, coord_y: coordinates.y) if coordinates.x < Board::SIZE - 1

    # check if cell is at the bottom left
    surrounding_cells << Pair.new(coord_x: coordinates.x - 1, coord_y: coordinates.y - 1) if coordinates.y.positive? && coordinates.x.positive?

    # check if cell is at the top left
    surrounding_cells << Pair.new(coord_x: coordinates.x - 1, coord_y: coordinates.y + 1) if coordinates.y < Board::SIZE - 1 && coordinates.x.positive?

    # check if cell is at the bottom right
    surrounding_cells << Pair.new(coord_x: coordinates.x + 1, coord_y: coordinates.y - 1) if coordinates.y.positive? && coordinates.x < Board::SIZE - 1

    # check if cell is at the top right
    surrounding_cells << Pair.new(coord_x: coordinates.x + 1, coord_y: coordinates.y + 1) if coordinates.y < Board::SIZE - 1 && coordinates.x < Board::SIZE - 1

    surrounding_cells
  end

  def number_of_surrounding_mines(attempt)
    cell_values = cell_values(surrounding_cells(attempt))
    cell_values.count(Board::MINE)
  end

  def cell_values(cells)
    cells.each_with_object([]) do |cell, memo|
      memo << @board.with_mines[cell.y][cell.x]
    end
  end

  def show_empty_adjacent_cells(cell)
    surrounding_cells(cell).each do |surrounding_cell|
      if @empty_cells.one? { |e| e.x == surrounding_cell.x && e.y == surrounding_cell.y }
        next
      end

      reveal_adjacent_cells_on_board(surrounding_cell)
    end
  end

  def reveal_adjacent_cells_on_board(cell)
    cell_value = number_of_surrounding_mines(cell)

    if cell_value.zero?
      @empty_cells << cell

      @board.visible[cell.y][cell.x] = Board::EMPTY
      show_empty_adjacent_cells(cell)
    else
      @board.visible[cell.y][cell.x] = cell_value
    end
  end
end
