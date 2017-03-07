module Api
  module V1
    class RecipesController < ApplicationController
      before_action :authenticate_user, except: [:index, :show]
      before_action :set_recipe, only: [:show, :update, :destroy]

      def index
        @recipes = Recipe.all
        render json: @recipes.as_json(include: [:tags, :ingredients, :comments, :like_users, :book_users], methods: [:likes, :books])
      end

      def show
        render json: @recipe.as_json(include: [:tags, :ingredients, :comments, :like_users, :book_users], methods: [:likes, :books])
      end

      def create
        @recipe = current_user.recipes.new(recipe_params)

        tags_params.each do |tag|
          @recipe.tags << Tag.find_or_create_by(name: tag)
        end

        ingredients_params.each do |ingr|
          @recipe.ingredients.new(label: ingr[:label], quantity: ingr[:quantity], unit: ingr[:unit])
        end

        if @recipe.save
          render json: @recipe.as_json(include: [:tags, :ingredients]), status: :created
        else
          render json: @recipe.errors, status: :unprocessable_entity
        end
      end

      def update
        if @recipe.update(recipe_params)
          render json: @recipe
        else
          render json: @recipe.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @recipe.destroy
      end

      def like
        recipe = Recipe.find(params[:recipe_id])
        recipe.like_users << current_user unless recipe.like_users.include?(current_user)
      end

      private
      def set_recipe
        @recipe = Recipe.find(params[:id])
      end

      def recipe_params
        params.permit(:description, :price, :time, :serving, :publication, :likes, steps: [])
      end

      def tags_params
        params.permit(:tags)
      end

      def ingredients_params
        params.permit(ingredients: [:label, :quantity, :unit])[:ingredients]
      end
    end
  end
end
