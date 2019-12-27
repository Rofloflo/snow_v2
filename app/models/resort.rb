class Resort < ApplicationRecord
  belongs_to :state
  has_many :snow_data
  validates :state_id, presence: true
end
