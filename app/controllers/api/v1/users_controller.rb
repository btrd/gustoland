module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user, except: [:show, :create]

      def index
        current_user_id = current_user ? current_user.id : nil
        render json: current_user.as_json(include: [:recipes, :follows, :follow_by, :like_recipes, :book_recipes], current_user: current_user_id)
      end

      def show
        user = User.find(params[:id])
        current_user_id = current_user ? current_user.id : nil
        render json: user.as_json(include: [:recipes, :follows, :follow_by, :like_recipes, :book_recipes], current_user: current_user_id)
      end

      def create
        user = User.new(user_params)
        if user.save
          render json: user
        else
          render json: user.errors.messages, status: :unprocessable_entity
        end
      end

      def update
        if current_user.update(user_params)
          render status: 200
        else
          render json: current_user.errors.messages, status: :unprocessable_entity
        end
      end

      def follow
        user = User.find(params[:user_id])
        byebug
        current_user.follows << user unless current_user.follows.include?(user) || current_user == user
      end

      def unfollow
        user = User.find(params[:user_id])
        current_user.follows.delete(user) if current_user.follows.include?(user)
      end

      private
      def user_params
        params.permit(:nickname, :email, :name, :password, :image)
      end
    end
  end
end
