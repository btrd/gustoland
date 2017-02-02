module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user, except: [:create]

      def show
        render json: current_user
      end

      def create
        user = User.new(user_params)
        if user.save
          render json: user
        else
          render json: user.errors.messages
        end
      end

      def update
        byebug
        if current_user.update(user_params)
          render status: 200
        else
          render json: current_user.errors.messages
        end
      end

      private

      def user_params
        params.require(:user).permit(:nickname, :email, :name, :password)
      end
    end
  end
end
