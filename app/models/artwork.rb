class Artwork < ApplicationRecord
    belongs_to :artist
    has_many :image_files, dependent: :destroy
end
