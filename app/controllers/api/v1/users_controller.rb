module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user, except: [:show, :create]

      def index
        render json: current_user.as_json(include: [:recipes, :follow, :follow_by, :like_recipes, :book_recipes])
      end

      def show
        user = User.find(params[:id])
        render json: user.as_json(include: [:recipes, :follow, :follow_by, :like_recipes, :book_recipes])
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
        if current_user.update(user_params)
          render status: 200
        else
          render json: current_user.errors.messages
        end
      end

      def follow
        user = User.find(params[:user_id])
        byebug
        current_user.follow << user unless current_user.follow.include?(user) || current_user == user
      end

      def unfollow
        user = User.find(params[:user_id])
        current_user.follow.delete(user) if current_user.follow.include?(user)
      end

      private
      def user_params
        params.permit(:nickname, :email, :name, :password)
      end
    end
  end
end
