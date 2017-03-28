class Api::V1::Users::AssignmentsController < Api::V1::BaseController
  def index
    user = User.find(params[:id])
    render json: user.find_assignments_and_users
  end
end