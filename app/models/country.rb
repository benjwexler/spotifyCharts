class Country < ApplicationRecord
    validates :country_code, uniqueness: true
    has_many :charts
    has_many :songs, through: :charts
    
end
