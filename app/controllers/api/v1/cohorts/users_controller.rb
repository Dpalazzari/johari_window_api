class Api::V1::Cohorts::UsersController < Api::V1::BaseController

  def index
    cohort = Cohort.find(params[:cohort_id])
    render json: cohort.users
  end

end