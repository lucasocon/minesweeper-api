# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::GamesController, type: :controller do
  describe 'POST #create' do
    it 'returns a success response' do
      post :create

      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    let(:game) { FactoryBot.create(:game) }
    let(:invalid_id) { game.id + 1 }
    let(:game_params) do
      {
        x: 1,
        y: 1
      }
    end

    context 'with a valid id' do
      it 'returns a success response' do
        post :update, params: {
          id: game.id,
          game: game_params
        }

        expect(response).to be_successful
        expect(@controller.instance_variable_get(:@game).id).to eq(game.id)
      end
    end

    context 'with invalid id' do
      it 'should return game not found' do
        post :update, params: {
          id: game.id + 1,
          game: game_params
        }

        expect(response).to have_http_status(404)
      end
    end
  end
end
