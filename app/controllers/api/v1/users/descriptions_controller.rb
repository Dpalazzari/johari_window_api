class Api::V1::Users::DescriptionsController < Api::V1::BaseController
  
  def create
    describee    = User.find(params[:id])
    descriptions = JSON.parse(request.body.read)
    describer    = User.find(descriptions['describer_id'])
    assignment   = Assignment.where("assignee_id = ? AND assigned_id = ?", describer.id, describee.id).first
    descriptions['johari'].each do |joh|
      adj = Adjective.find_by(name: joh)
      describee.descriptions.create(describer_id: describer.id, adjective_id: adj.id)
    end
    assignment.update(completed?: true)
    assignment.save
    render status: 202
  end

end