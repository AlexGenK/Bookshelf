class Book < ApplicationRecord
  belongs_to :category
  has_and_belongs_to_many :authors
  has_attached_file :cover, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "no_cover.png"

  validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\Z/
end
