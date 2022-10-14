module Api
  module V1
    class ShopsController < ApplicationController
      def index
        shops = Shop.all

        render json: shops, status: :ok
      end

      def show
        shop = Shop.find(params[:id])

        render json: shop, status: :ok
      end

      def create
        shop = Shop.new(shop_params)

        if shop.save
          render json: shop, status: :created
        end
      end

      def update
        shop = Shop.find(params[:id])

        if shop.update(shop_params)
          render json: shop, status: :ok
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
        params.require(:data).
               require(:attributes).
               permit(:name)
      end
    end
  end
end
