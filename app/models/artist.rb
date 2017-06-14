class Artist < ApplicationRecord
    validates :first_name, presence: true
    
    has_many :artworks, dependent: :destroy
end
