module Api
  module V1
    class CardsController < ApplicationController
      def index
        cards = Card.all

        cards = Card.by_user(params.dig(:filter, :user_id)) if params.dig(:filter, :user_id)
        cards = Card.by_shop(params.dig(:filter, :shop_id)) if params.dig(:filter, :shop_id)

        render json: cards, status: :ok
      end

      def show
        card = Card.find(params[:id])

        render json: card, status: :ok
      end
    end
  end
end
