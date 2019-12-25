class Resort < ApplicationRecord
  belongs_to :state
  validates :state_id, presence: true
end
