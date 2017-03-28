class Api::V1::AdjectivesController < Api::V1::BaseController

  def index
    render json: Adjective.pluck(:name)
  end

end