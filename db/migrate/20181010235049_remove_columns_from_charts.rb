class RemoveColumnsFromCharts < ActiveRecord::Migration[5.2]
  def change
    remove_column(:charts, :country_code)
    remove_column(:charts, :spotify_id)
    add_column :charts, :country, :integer
    add_column :charts, :song, :integer 

  end
end
