class IllustrationComment < ApplicationRecord
  belongs_to :end_user
  belongs_to :illustration
  validates :comment, presence: true,
    length: { maximum: 1000 }
end
