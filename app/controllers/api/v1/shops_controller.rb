# frozen_string_literal: true

module Api
  module V1
    class ShopsController < ApplicationController
      def index
        if params[:filter]
          shops = User.find(params.dig(:filter, :user_id)).shops if params.dig(:filter, :user_id)
          shop = Card.find(params.dig(:filter, :card_id)).shop if params.dig(:filter, :card_id)
        else
          shops = Shop.all
        end

        render json: shops || shop, status: :ok
      end

      def show
        shop = Shop.find(params[:id])

        render json: shop, status: :ok
      end

      def create
        shop = Shop.new(shop_params)

        if shop.save
          render json: shop, status: :created
        else
          render json: shop, status: 422, serializer: ActiveModel::Serializer::ErrorSerializer
        end
      end

      def update
        shop = Shop.find(params[:id])

        if shop.update(shop_params)
          render json: shop, status: :ok
        else
          render json: shop, status: 422, serializer: ActiveModel::Serializer::ErrorSerializer
        end
      end

      def buy
        buy_info = JSON.parse(request.body.string)
        buy_info['shop_id'] = params[:id].to_i

        buy_result_json = BuyProcess.call(buy_info)

        render json: buy_result_json
      end

      private

      def shop_params
        params.require(:data)
              .require(:attributes)
              .permit(:name)
      end
    end
  end
end
