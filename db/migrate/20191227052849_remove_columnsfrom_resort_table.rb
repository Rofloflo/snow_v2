class RemoveColumnsfromResortTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :resorts, :recent_time
    remove_column :resorts, :recent_snowfall
    remove_column :resorts, :next_snowfall
    remove_column :resorts, :next5_snowfall
  end
end
