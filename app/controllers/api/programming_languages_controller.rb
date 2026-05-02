class Api::ProgrammingLanguagesController < ApplicationController
  def index
    @programming_languages = ProgrammingLanguage.all
    render json: { data: ProgrammingLanguageSerializer.render_as_json(@programming_languages) }, status: :ok
  end
end
