module Api
  module V1
    class SearchController < ApplicationController
      def index
        @query = params[:query].downcase
        @sort  = params[:sort]

        recipes = search_recipe
        users   = search_user

        current_user_id = current_user ? current_user.id : nil

        recipes_json = recipes.as_json(
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

        users_json = users.as_json

        render json: { recipes: recipes_json, users: users_json }
      end

      private
      def search_recipe
        res_recipes = []
        recipes = Recipe.all
        tag = Tag.find_by(name: @query)
        
        res_recipes.concat(recipes.to_a.select { |r| r.tags.include?(tag) }) if tag
        res_recipes.concat(recipes.where("lower(description) LIKE ?", "%#{@query}%"))

        res_recipes = res_recipes.uniq

        if params[:sort] || params[:sort] == 'date'
          res_recipes = res_recipes.sort_by { |r| r.created_at }.reverse
        else
          res_recipes = res_recipes.sort_by { |r| r.popularity }.reverse
        end
        res_recipes
      end

      def search_user
        users = User.where("lower(name) LIKE ? OR lower(email) LIKE ? OR lower(nickname) LIKE ?", "%#{@query}%", "%#{@query}%", "%#{@query}%")

        if params[:sort] || params[:sort] == 'date'
          res_user = users.sort_by { |r| r.created_at }.reverse
        else
          res_user = users.sort_by { |r| r.comments.count }.reverse
        end
        res_user
      end
    end
  end
end
