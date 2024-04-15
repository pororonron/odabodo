class ThemeTag < ApplicationRecord
  has_many :theme_tag_middles, dependent: :destroy
  has_many :themes, through: :theme_tag_middles
  validates :name,
    length: { maximum: 30 }
end
