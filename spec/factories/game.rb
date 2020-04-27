# frozen_string_literal: true

FactoryBot.define do
  factory :game do
    board do
      [
        %w[h h h h h h h h h h],
        %w[h h h h h h h h h h],
        %w[h h h h h h h h h h],
        %w[h h h h h h h h h h],
        %w[h h h h h h h h h h],
        %w[h h h h h h h h h h],
        %w[h h h h h h h h h h],
        %w[h h h h h h h h h h],
        %w[h h h h h h h h h h],
        %w[h h h h h h h h h h]
      ]
    end
    mines_board do
      [
        %w[h h h h x h h h h h],
        %w[h x h h h h h h x h],
        %w[h h h h x h h h h h],
        %w[h h h h x h h h h h],
        %w[h h h h x h h h h h],
        %w[h h h h h h h h x h],
        %w[h x h h h h h h h h],
        %w[h h h x h h h h h h],
        %w[h h h h x h h h h h],
        %w[h x h h h h h h h h]
      ]
    end
    lost { false }
    won { false }
  end
end
