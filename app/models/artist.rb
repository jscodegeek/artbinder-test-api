class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class Artist < ApplicationRecord
    validates :first_name, presence: true
    validates :email, presence: true, uniqueness: true, email: true
    has_many :artworks, dependent: :destroy
end
