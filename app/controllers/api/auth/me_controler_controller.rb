class Api::Auth::MeController < ApplicationController
  before_action :authenticated!

  def show
    render json: {
      data: UserSerializer.render_as_json(@current_user)
    }
  end
end
