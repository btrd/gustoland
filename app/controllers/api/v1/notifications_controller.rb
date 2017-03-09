module Api
  module V1
    class NotificationsController < ApplicationController
      before_action :authenticate_user

      def index
        notifications = current_user.notifications
        render json: notifications.sort_by(&:created_at).reverse
        notifications.each { |n| n.seen! }
      end
    end
  end
end
