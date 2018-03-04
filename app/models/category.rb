class Category < ApplicationRecord
  has_many :books

  validates :name, presence: true
  validates :name, uniqueness: true
  
  def self.default_category
    category = Category.find_by(name: 'Other')
    return Category.create(name: 'Other') unless category
    return category
  end
end
