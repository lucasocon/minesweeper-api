# frozen_string_literal: true

# Game model
class Game < ApplicationRecord
  after_create :create_boards

  private

  def create_boards
    board = Board.new
    self.board = board.visible
    self.mines_board = board.with_mines

    save
  end
end
