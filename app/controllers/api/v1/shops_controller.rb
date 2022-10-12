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
        shop = Shop.new(name: params[:name])

        if shop.save
          render json: shop, status: :created
        end
      end

      def update
        shop = Shop.find(params[:id])

        if shop.update(name: params[:name])
          render json: shop, status: :ok
        end
      end

      def buy
      end
    end
  end
end
