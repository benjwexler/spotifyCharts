class CreateCharts < ActiveRecord::Migration[5.2]
  def change
    create_table :charts do |t|
      t.string :country_code
      t.integer :position
      t.string :spotify_id

      t.timestamps
    end
  end
end
