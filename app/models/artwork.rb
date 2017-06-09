class Artwork < ApplicationRecord
    validates :title, :description, :price, :width, :height, :is_published, presence: true
    validates :price, :width, :height, numericality: { only_integer: true }
    belongs_to :artist
    has_many :image_files, dependent: :destroy
end
