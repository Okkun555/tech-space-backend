class ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection
  include RenderHelper

  protect_from_forgery with: :null_session, unless: -> { Rails.env.test? }

  before_action :authenticated!

  rescue_from ActiveRecord::RecordInvalid, with: :rescue_record_invalid

  private
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

  def authenticated!
    render_unauthorized unless current_user
  end
end
