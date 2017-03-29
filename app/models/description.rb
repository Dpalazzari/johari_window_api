class Description < ApplicationRecord
  belongs_to :describee, class_name: "User"
  belongs_to :describer, class_name: "User"
  belongs_to :adjective

  def self.find_adjectives(descriptions)
    descriptions.map do |description|
      Adjective.find(description.adjective_id)
    end
  end
end
