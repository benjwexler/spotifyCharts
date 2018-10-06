class Song < ApplicationRecord
    validates :spotify_id, uniqueness: true
end
