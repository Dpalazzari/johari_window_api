class Api::V1::UsersController < Api::V1::BaseController

  def create
    user_attributes = JSON.parse(request.body.read)
    user = User.new(user_attributes)
    if user.save
      render json: user
    else
      render json: {error: 'User not created'}, status: 400
    end
  end

end