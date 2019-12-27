class MoveColumnDataToSnowDataTable < ActiveRecord::Migration[6.0]
  def change
    Resort.find_each do |resort|
      resort.snow_datum.create(
      :recent_time => resort.recent_time,
      :recent_snowfall => resort.recent_snowfall,
      :next_snowfall => resort.next_snowfall,
      :next5_snowfall => resort.next5_snowfall
      )
    end
  end
end
