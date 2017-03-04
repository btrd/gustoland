module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authenticate_user

      def create
        comment = current_user.comments.new(comment_params)
        if comment.save
          render json: comment
        else
          render json: comment.errors.messages
        end
      end

      def update
        comment = Comment.find(params[:id])
        if comment.user_id != current_user.id
          render status: 401
        else
          if comment.update(content: params[:content])
            render status: 200
          else
            render json: comment.errors.messages
          end
        end
      end

      private
      def comment_params
        params.permit(:content, :recipe_id)
      end
    end
  end
end
