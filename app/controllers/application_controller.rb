class ApplicationController < ActionController::API
  include Knock::Authenticable
  before_action :set_raven_context

  private

  def set_raven_context
    Raven.user_context(id: current_user.id) if current_user
  end
end
