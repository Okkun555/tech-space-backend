class ProfileSerializer < Blueprinter::Base
  identifier :id

  fields :name, :birthday, :gender, :introduction

  association :occupation, blueprint: OccupationSerializer
end
