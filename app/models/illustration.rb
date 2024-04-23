class Illustration < ApplicationRecord
  has_many_attached :challenged_images
  belongs_to :end_user
  belongs_to :theme
  belongs_to :challenge_theme
  has_many :illustration_tag_middles, dependent: :destroy
  has_many :illustration_tags, through: :illustration_tag_middles
  validates :title, presence: true,
    length: { maximum: 30 }
  validates :detail,
    length: { maximum: 1000 }
end
