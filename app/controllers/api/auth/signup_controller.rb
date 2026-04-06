class Api::Auth::SignupController < ApplicationController
  def create
    user = User.new(signup_params)
    if user.save
      session[:user_id] = user.id
      render json: {
        data: UserSerializer.render_as_json(user)
      }, status: :created
    else
      render json: { errors: ErrorSerializer.render(user.errors) }, status: :unprocessable_entity
    end
  end

  private
    def signup_params
      params.expect(user: [:email, :password, :password_confirmation])
    end
end
