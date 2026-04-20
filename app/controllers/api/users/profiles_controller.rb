class Api::Users::ProfilesController < ApplicationController
  def create
    profile = Profile.create!(profile_params.merge(user: current_user))
    render json: {
      data: ProfileSerializer.render_as_json(profile)
    }, status: :created
  end

  private
    def profile_params
      params.expect(profile: %i[name birthday gender occupation_id introduction])
    end
end
