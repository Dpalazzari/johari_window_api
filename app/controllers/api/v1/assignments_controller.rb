class Api::V1::AssignmentsController < Api::V1::BaseController
  def create
    groups = JSON.parse(request.body.read)
    AssignmentCreator.make_assignments(groups)
    render status: 200
  end
end