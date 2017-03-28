class Description < ApplicationRecord
  belongs_to :describee, class_name: "User"
  belongs_to :describer, class_name: "User"
  belongs_to :adjective
end
