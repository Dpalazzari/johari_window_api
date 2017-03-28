class Adjective < ApplicationRecord
  has_many :descriptions
  has_many :users, through: :descriptions, source: :describee
end
