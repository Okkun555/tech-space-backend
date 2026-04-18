class Api::Auth::MeController < ApplicationController
  def show
    render json: {
      data: UserSerializer.render_as_json(@current_user)
    }
  end
end
