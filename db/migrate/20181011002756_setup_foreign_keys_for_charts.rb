class SetupForeignKeysForCharts < ActiveRecord::Migration[5.2]
  def change
    remove_column(:charts, :country)
    remove_column(:charts, :song)
    add_column :charts, :country_id, :integer
    add_column :charts, :song_id, :integer 
  end
end
