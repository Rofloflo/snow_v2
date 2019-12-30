class Resort < ApplicationRecord
  belongs_to :state
  has_many :snow_data
  validates :state_id, presence: true #uniqueness scope to resort name
end
