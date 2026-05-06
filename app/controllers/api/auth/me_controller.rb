class Api::Auth::MeController < ApplicationController
  def show
    user = User.preload(profile: :occupation).find(current_user.id)
    render json: {
      data: UserSerializer.render_as_json(user, view: :with_profile)
    }
  end
end
