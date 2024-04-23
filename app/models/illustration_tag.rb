class IllustrationTag < ApplicationRecord
  has_many :illustration_tag_middles, dependent: :destroy
  has_many :illustrations, through: :illustration_tag_middles
  validates :name, presence: true,
    length: { maximum: 30 }
end
