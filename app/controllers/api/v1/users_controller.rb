module Api
  module V1
    class UsersController < ApplicationController
      def index
        users = User.all

        render json: users, status: :ok
      end

      def show
        user = User.find(params[:id])

        render json: user, status: :ok
      end

      def create
        user = User.create(user_params_for_create)

        if user.save
          render json: user, status: :created
        end
      end

      def update
        user = User.find(params[:id])

        if user.update(user_params_for_update)
          render json: user, status: :ok
        end
      end

      private

      def user_params_for_create
        params.require(:data).
               require(:attributes).
               permit(:email)
      end

      def user_params_for_update
        params.require(:data).
               require(:attributes).
               permit(:email, :negative_balance)
      end
    end
  end
end
