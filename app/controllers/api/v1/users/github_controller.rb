class Api::V1::Users::GithubController < Api::V1::BaseController

  def show
    user = User.find_by(github: params[:name])
    if user 
      render json: user
    else
      render status: 404
    end
  end
end
