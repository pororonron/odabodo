class ThemeTagMiddle < ApplicationRecord
  belongs_to :theme
  belongs_to :theme_tag
  validates :theme_id, presence: true
  validates :theme_tag_id, presence: true
end
