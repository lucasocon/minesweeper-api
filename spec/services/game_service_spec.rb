RSpec.describe GameService do
  describe 'initialize' do
    let(:game) { FactoryBot.create(:game) }
    let(:coord_x) { 1 }
    let(:coord_y) { 1 }
    let(:attempt) { Pair.new(coord_x: coord_x - 1, coord_y: coord_y - 1) }

    subject { described_class.new(game, coord_x, coord_y) }

    it 'should return correct values' do
      expect(subject).to be_an_instance_of(GameService)
      expect(subject.attempt.x).to eq(attempt.x)
      expect(subject.attempt.y).to eq(attempt.y)
    end
  end

  describe '#call' do
    context 'with a lost game' do
      let(:game) { FactoryBot.create(:game, lost: true) }
      let(:coord_x) { 1 }
      let(:coord_y) { 1 }

      subject { described_class.new(game, coord_x, coord_y) }

      it 'should return message and game' do
        result = subject.call

        expect(result.message).to eq('Sorry, the game is over, please try again.')
        expect(result.game).to eq game
      end
    end
  end
end
