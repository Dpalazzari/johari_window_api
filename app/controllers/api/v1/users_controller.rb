class Api::V1::UsersController < Api::V1::BaseController

  def create
    found_user = User.find_by(github: params[:user][:github])
    if found_user
      render json: found_user
    else
      user = User.new(user_params)
      if user.save
        user.add_cohort
        render json: user
      else
        render json: {error: 'User not created'}, status: 400
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:github,:token)
  end
end
