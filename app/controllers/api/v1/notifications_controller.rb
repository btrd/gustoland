module Api
  module V1
    class NotificationsController < ApplicationController
      before_action :authenticate_user

      def index
        notifications = current_user.notifications
        notifications = notifications.sort_by(&:created_at).reverse
        render json: notifications.as_json(methods: :image)
        notifications.each { |n| n.seen! }
      end
    end
  end
end
