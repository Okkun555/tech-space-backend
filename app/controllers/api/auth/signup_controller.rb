class Api::Auth::SignupController < ApplicationController
  def create
    user = User.create!(signup_params)
    session[:user_id] = user.id
    render json: { data: UserSerializer.render_as_json(user) }, status: :created
  end

  private
    def signup_params
      params.expect(user: [:email, :password, :password_confirmation])
    end
end
