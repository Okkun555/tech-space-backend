class PostSerializer < Blueprinter::Base
  identifier :id
  fields :content, :created_at


  association :profile, blueprint: ProfileSerializer
end