class Api::V1::Users::DescriptionsController < Api::V1::BaseController

  def index
    describee = User.find(params[:id])
    render json: Johari.new(describee).format_descriptions 
  end
  
  def create
    describee    = User.find(params[:id])
    descriptions = JSON.parse(request.body.read)
    describer    = User.find(descriptions['describer_id'])
    render status: 402 and return if Assignment.valid?(describee.id, describer.id)
    describee.create_descriptions(descriptions['johari'], describer)
    if describee.all_descriptions_completed?(describer.id, descriptions['johari'])
      Assignment.complete(describee.id, describer.id)
      render status: 202
    else
      render status: 304
    end
  end

end
