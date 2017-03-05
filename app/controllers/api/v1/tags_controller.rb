module Api
  module V1
    class TagsController < ApplicationController
      def index
        tags = Tag.all.sort_by { |t| t.recipes.count }
        render json: tags
      end
    end
  end
end
