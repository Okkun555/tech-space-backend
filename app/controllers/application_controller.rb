class ApplicationController < ActionController::API
  include ActionController::Cookies
  include Pagy::Method
  include Pundit::Authorization
  include RenderHelper

  before_action :authenticated!

  rescue_from ActiveRecord::RecordInvalid, with: :rescue_record_invalid
  rescue_from Pundit::NotAuthorizedError, with: :rescue_forbidden

  private
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_profile
    @current_profile = @current_user&.profile
  end

  def authenticated!
    render_unauthorized unless current_user
  end
end
