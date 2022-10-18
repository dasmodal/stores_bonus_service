# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def index
        if params[:filter]
          users = Shop.find(params.dig(:filter, :shop_id)).users if params.dig(:filter, :shop_id)
          user = Card.find(params.dig(:filter, :card_id)).user if params.dig(:filter, :card_id)
        else
          users = User.all
        end

        render json: users || user, status: :ok
      end

      def show
        user = User.find(params[:id])

        render json: user, status: :ok
      end

      def create
        user = User.create(user_params_for_create)

        if user.save
          render json: user, status: :created
        else
          binding.pry
          render json: user, status: 422, serializer: ActiveModel::Serializer::ErrorSerializer
        end
      end

      def update
        user = User.find(params[:id])

        if user.update(user_params_for_update)
          render json: user, status: :ok
        else
          render json: user, status: 422, serializer: ActiveModel::Serializer::ErrorSerializer
        end
      end

      private

      def user_params_for_create
        params.require(:data)
              .require(:attributes)
              .permit(:email)
      end

      def user_params_for_update
        params.require(:data)
              .require(:attributes)
              .permit(:email, :negative_balance)
      end
    end
  end
end
