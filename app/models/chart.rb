class Chart < ApplicationRecord
    validates :country_id, uniqueness: { scope: :song_id }
    belongs_to :song
    belongs_to :country
  
   
end 
