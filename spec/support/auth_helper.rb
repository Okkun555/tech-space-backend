module AuthHelper
  def login(user)
    params = { session: { email: user.email, password: "password123" } }
    post api_auth_login_path, params:
  end
end
