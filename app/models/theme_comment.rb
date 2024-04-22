class ThemeComment < ApplicationRecord
  belongs_to :end_user
  belongs_to :theme
  validates :comment, presence: true,
    length: { maximum: 1000 }
end
