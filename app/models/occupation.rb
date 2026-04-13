class Occupation < ApplicationRecord
  validates :name, uniqueness: true, length: { maximum: 100 }
end
