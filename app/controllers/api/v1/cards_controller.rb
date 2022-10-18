# frozen_string_literal: true

module Api
  module V1
    class CardsController < ApplicationController
      def index
        cards = Card.all

        cards = Card.by_user(params.dig(:filter, :user_id)) if params.dig(:filter, :user_id)
        cards = Card.by_shop(params.dig(:filter, :shop_id)) if params.dig(:filter, :shop_id)

        meta = bonuses_sum(cards)

        render json: cards, status: :ok, meta:
      end

      def show
        card = Card.find(params[:id])

        render json: card, status: :ok
      end

      private

      def bonuses_sum(cards)
        if params.dig(:stats, :bonuses) == 'sum'
          sum = cards.pluck(:bonuses).sum

          { "stats": { "bonuses": { "sum": sum } } }
        end
      end
    end
  end
end
