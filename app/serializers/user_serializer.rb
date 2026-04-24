class UserSerializer < Blueprinter::Base
  identifier :id

  field :email

  view :with_profile do
    association :profile, blueprint: ProfileSerializer, if: ->(_field_name, user, _options) { user.profile.present? }
  end
end
