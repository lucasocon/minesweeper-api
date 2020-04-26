# frozen_string_literal: true

# Game model
class Game < ApplicationRecord
  validates_presence_of :board, :mines_board

  after_initialize :create_boards

  private

  def create_boards
    board = Board.new
    self.board = board.visible
    self.mines_board = board.with_mines
  end
end
