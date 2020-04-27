# frozen_string_literal: true

RSpec.describe Game, type: :model do
  describe 'factory' do
    it 'has a valid factory' do
      expect(FactoryBot.build(:game)).to be_valid
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:board) }
    it { should validate_presence_of(:mines_board) }
  end
end
