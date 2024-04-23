class ChallengeTheme < ApplicationRecord
  belongs_to :end_user
  belongs_to :theme
  has_many :illustrations, dependent: :destroy
  validates :end_user, uniqueness: {scope: :theme}
end
