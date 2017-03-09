module Api
  module V1
    class SearchController < ApplicationController
      def index
        res_recipes = []
        query = params[:query].downcase

        recipes = Recipe.all
        tag = Tag.find_by(name: query)
        
        res_recipes.concat(recipes.to_a.select { |r| r.tags.include?(tag) }) if tag
        res_recipes.concat(recipes.where("lower(description) LIKE ?", "%#{query}%"))

        current_user_id = current_user ? current_user.id : nil

        res_recipes.uniq!

        if params[:sort] || params[:sort] == 'date'
          res_recipes.sort_by! { |r| r.created_at }.reverse!
        else
          res_recipes.sort_by! { |r| -(r.likes + r.books) }
        end

        render json: res_recipes.uniq.as_json(
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
    end
  end
end
