class Category < ApplicationRecord
  has_many :books
  
  def self.default_category
    Category.find_by name: 'Прочее'
  end
end
