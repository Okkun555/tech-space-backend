class Api::Auth::SessionsController < ApplicationController
  skip_before_action :authenticated!, only: [ :create ]
  def create
    user = User.find_by(email: login_params[:email])

    if user && user.authenticate(login_params[:password])
      session[:user_id] = user.id
      render json: { data: UserSerializer.render_as_json(user) }, status: :ok
    else
      render_unauthorized(message: "メールアドレスまたはパスワードが正しくありません", code: "invalid_credentials")
    end
  end

  def destroy
    reset_session
    head :no_content
  end

  private
    def login_params
      params.expect(session: [ :email, :password ])
    end
end
