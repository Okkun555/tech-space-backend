class Api::Users::ProfilesController < ApplicationController
  def create
    params = profile_params
    form = Profiles::CreateForm.new(user: current_user, attributes: params)
    profile = form.save!

    render json: {
      data: ProfileSerializer.render_as_json(profile)
    }, status: :created
  end

  private
    def profile_params
      params.expect(profile: [
        :name, :birthday, :gender, :occupation_id, :introduction,
        { programming_languages: [ [ :id, :experience_years ] ] },
        { sns_links: [ [:service_name, :link] ] }
      ])
    end
end
