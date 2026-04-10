class Api::Auth::SessionsController < ApplicationController
  def create
    user = User.find_by(email: login_params[:email])

    if user && user.authenticate(login_params[:password])
      session[:user_id] = user.id
      render json: {
        data: UserSerializer.render_as_json(user),
      }, status: :ok
    else
      render json: { errors: [{ field: "base", message: "メールアドレスまたはパスワードが正しくありません" }] }, status: :unauthorized
    end
  end

  private
    def login_params
      params.expect(session: [:email, :password])
    end
end
