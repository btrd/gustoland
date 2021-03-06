module Api
  module V1
    class RecipesController < ApplicationController
      before_action :authenticate_user, except: [:index, :show]
      before_action :set_recipe, only: [:show, :update, :destroy]

      def index
        if params[:book] && current_user
          recipes = []
          recipes.concat(current_user.books)
          recipes.concat(current_user.recipes)
          current_user_id = current_user.id
        elsif params[:user_id]
          user = User.find(params[:user_id])
          recipes = user.recipes
          current_user_id = current_user ? current_user.id : nil
        elsif current_user
          followers = current_user.follows
          recipes = []
          followers.each { |f| recipes.concat(f.recipes) }
          recipes.concat(current_user.recipes)
          current_user_id = current_user.id
        else
          recipes = Recipe.all
          current_user_id = nil
        end
        recipes = recipes.sort_by { |r| r.created_at }.reverse
        render json: recipes.as_json(
                                      include: [
                                                  :tags,
                                                  :ingredients,
                                                  :like_users,
                                                  :book_users,
                                                  :user,
                                                  comments: {
                                                    include: :user
                                                  }
                                                ],
                                      methods: [:likes, :books],
                                      current_user: current_user_id
                                    )
      end

      def show
        current_user_id = current_user ? current_user.id : nil
        render json: @recipe.as_json(include: [:tags, :ingredients, :like_users, :book_users, :user, comments: { include: :user } ], methods: [:likes, :books], current_user: current_user_id)
      end

      def create
        @recipe = current_user.recipes.new(recipe_params)

        tags_params[:tags].each do |tag|
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
        unless recipe.like_users.include?(current_user)
          recipe.like_users << current_user
          Notification.like(current_user, recipe)
        end
      end

      def book
        recipe = Recipe.find(params[:recipe_id])
        unless recipe.book_users.include?(current_user)
          recipe.book_users << current_user
          Notification.book(current_user, recipe)
        end
      end

      def unlike
        recipe = Recipe.find(params[:recipe_id])
        recipe.like_users.delete(current_user) if recipe.like_users.include?(current_user)
      end

      def unbook
        recipe = Recipe.find(params[:recipe_id])
        recipe.book_users.delete(current_user) if recipe.book_users.include?(current_user)
      end

      def ask_more
        recipe = Recipe.find(params[:recipe_id])
        Notification.ask_more(current_user, recipe)
      end

      private
      def set_recipe
        @recipe = Recipe.find(params[:id])
      end

      def recipe_params
        params.permit(:description, :price, :time, :serving, :publication, :likes, :image, steps: [])
      end

      def tags_params
        params.permit(tags: [])
      end

      def ingredients_params
        params.permit(ingredients: [:label, :quantity, :unit])[:ingredients]
      end
    end
  end
end
