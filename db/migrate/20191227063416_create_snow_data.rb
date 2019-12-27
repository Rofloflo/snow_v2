class CreateSnowData < ActiveRecord::Migration[6.0]
  def change
    create_table :snow_data do |t|
      t.string :recent_time
      t.integer :recent_snowfall
      t.integer :next_snowfall
      t.integer :next5_snowfall
      t.integer :resort_id

      t.timestamps
    end
  end
end
