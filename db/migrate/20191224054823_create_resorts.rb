class CreateResorts < ActiveRecord::Migration[6.0]
  def change
    create_table :resorts do |t|
      t.string :resort_name
      t.string :resort_url
      t.string :recent_time
      t.integer :recent_snowfall
      t.integer :next_snowfall
      t.integer :next5_snowfall
      t.integer :state_id

      t.timestamps
    end
  end
end
