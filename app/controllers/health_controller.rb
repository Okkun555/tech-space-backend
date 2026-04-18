class HealthController < ApplicationController
  skip_before_action :authenticated!

  def check
    render json: { status: "ok" }
  end
end
