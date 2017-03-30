class Api::V1::Users::UsersController < Api::V1::BaseController

  def show
    render json: User.find(params[:id])
  end

end