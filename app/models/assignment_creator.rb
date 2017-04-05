class AssignmentCreator

  attr_reader :groups

  def initialize(groups)
    @groups = groups['group'].map { |group| map_to_models(group) }
  end

  def map_to_models(group)
    group.map { |user| User.find(user['id']) }
  end

  def self.make_assignments(groups)
    new(groups).make_assignments
  end

  def make_assignments
    groups.each { |group| create_group_assignments(group) }
  end

  def create_group_assignments(group)
    group.each do |assignee|
      create_individual_assignments(assignee, group)
    end
  end

  def create_individual_assignments(assignee, group)
    group.each do |assigned|
      create_unique_assignment(assignee, assigned)
    end
  end

  def create_unique_assignment(assignee, assigned)
    open_assignments = assignee.assignments.where(assigned: assigned, completed?: false)
    assignee.assignments.create(assigned: assigned) if open_assignments.empty?
  end
end