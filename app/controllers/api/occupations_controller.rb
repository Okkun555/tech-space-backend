class Api::OccupationsController < ApplicationController
  def index
    occupations = Occupation.all
    render json: {
      data: OccupationSerializer.render_as_json(occupations)
    }
  end
end
