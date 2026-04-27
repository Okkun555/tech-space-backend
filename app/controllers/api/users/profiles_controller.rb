class Api::Users::ProfilesController < ApplicationController
  def create
    params = profile_params
    programming_languages = params.delete(:programming_languages) || []
    sns_links = params.delete(:sns_links) || []

    profile = Profile.new(params.merge(user: current_user))
    programming_languages.each do |programming_language|
      profile.profile_programming_languages.build(
        programming_language_id: programming_language[:id],
        experience_years: programming_language[:experience_years],
      )
    end
    sns_links.each do |sns_link|
      profile.sns_links.build(
        service_name: sns_link[:service_name],
        link: sns_link[:link],
      )
    end
    profile.save!

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
