class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.string :name
      t.string :artist
      t.float :spotify_id
      t.float :acousticness
      t.float :danceability
      t.integer :duration_ms
      t.float :energy
      t.float :instrumentalness
      t.integer :key
      t.integer :liveness
      t.integer :mode
      t.float :speechiness
      t.float :tempo
      t.integer :time_signature
      t.float :valence

      t.timestamps
    end
  end
end
