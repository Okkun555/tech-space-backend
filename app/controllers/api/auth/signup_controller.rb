class Api::Auth::SignupController < ApplicationController
  def create
    user = User.new(signup_params)

    if user.save!
      session[:user_id] = user.id
      render json: UserSerializer.render(user), status: :created
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  private
    def signup_params
      params.expect(user: [:email, :password, :password_confirmation])
    end
end
