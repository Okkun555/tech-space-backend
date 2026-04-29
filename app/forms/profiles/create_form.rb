class Profiles::CreateForm
  include ActiveModel::API
  include ActiveModel::Attributes

  attribute :name, :string
  attribute :birthday, :date
  attribute :gender, :string
  attribute :occupation_id, :integer
  attribute :introduction, :string
  attribute :programming_languages, default: -> { [] }
  attribute :sns_links, default: -> { [] }

  def initialize(user:, **attributes)
    @user = user
    super(attributes)
  end

  def save!
    return false if invalid?

    profile = Profile.new(name:, birthday:, gender:, occupation_id:, introduction:, user: @user)
    programming_languages.each do |language|
      profile.profile_programming_languages.build(
        programming_language_id: language[:id],
        experience_years: language[:experience_years],
      )
    end
    sns_links.each do |sns_link|
      profile.sns_links.build(
        service_name: sns_link[:service_name],
        link: sns_link[:link],
      )
    end
    profile.save!
    profile
  end
end

