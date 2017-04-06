class Api::V1::CohortsController < Api::V1::BaseController

  def index
    render json: Cohort.all
  end

end