class Api::V1::Users::DescriptionsController < Api::V1::BaseController
  def create
    descriptions = JSON.parse(request.body.read)
    binding.pry
    user = User.find(params[:id])
  end
end