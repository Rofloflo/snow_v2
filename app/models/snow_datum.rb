class SnowDatum < ApplicationRecord
  belongs_to :resort
  def self.convert_data_cm(data)
    data.nil? ? nil : data *2.54
  end
end
