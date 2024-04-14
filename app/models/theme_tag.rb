class ThemeTag < ApplicationRecord
  has_many :theme_tag_middles, dependent: :destroy
  validates :name,
    length: { maximum: 30 }
end
