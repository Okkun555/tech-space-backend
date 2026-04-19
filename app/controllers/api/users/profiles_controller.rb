class Api::Users::ProfilesController < ApplicationController
  def create
    return render_conflict(message: "プロフィールは作成済みです") if current_user.profile.present?

    profile = current_user.create_profile!(profile_params)
    render json: {
      data: ProfileSerializer.render_as_json(profile)
    }, status: :created
  end

  private
    def profile_params
      params.expect(profile: %i[name birthday gender occupation_id introduction])
    end
end
