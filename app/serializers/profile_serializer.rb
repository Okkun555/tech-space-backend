class ProfileSerializer < Blueprinter::Base
  identifier :id

  field :name

  view :detail do
    fields :birthday, :gender, :introduction
    association :occupation, blueprint: OccupationSerializer
  end
end
