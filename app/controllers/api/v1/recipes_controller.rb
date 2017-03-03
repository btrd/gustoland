module Api
  module V1
    class RecipesController < ApplicationController
      before_action :set_recipe, only: [:show, :update, :destroy]

      def index
        @recipes = Recipe.all
        render json: @recipes.as_json(include: { tags: {only: :name} })
      end

      def show
        render json: @recipe.as_json(include: { tags: {only: :name} })
      end

      def create
        @recipe = Recipe.new(recipe_params)

        tags_params.each do |tag|
          @recipe.tags << Tag.find_or_create_by(name: tag)
        end

        if @recipe.save
          render json: @recipe, status: :created
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
    end
  end
end
