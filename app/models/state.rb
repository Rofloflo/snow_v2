class State < ApplicationRecord
  has_many :resorts
  validates :state_url, length: { maximum: 255}, presence: true, uniqueness: true
end
