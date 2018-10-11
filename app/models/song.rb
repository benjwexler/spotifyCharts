class Song < ApplicationRecord
    validates :spotify_id, uniqueness: true
    has_many :charts
    has_many :countries, through: :charts
    
   
end
