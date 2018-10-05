class ChangeSpotifyIdToString < ActiveRecord::Migration[5.2]
  def change
    change_column(:songs, :spotify_id, :string)
  end
end
