module Api
  module V1
    class NotificationsController < ApplicationController
      before_action :authenticate_user

      def index
        notif = current_user.notifications
        notif = notif.sort_by(&:created_at).reverse

        notifications = []
        notifications.concat(notif.select { |n| !n.seen })
        notifications.concat(notif.select(&:seen).first(5))

        render json: notifications.as_json(methods: :image)

        notifications.each { |n| n.seen! }
      end
    end
  end
end
