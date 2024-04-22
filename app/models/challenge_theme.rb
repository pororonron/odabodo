class ChallengeTheme < ApplicationRecord
  belongs_to :end_user
  belongs_to :theme
  validates :end_user, uniqueness: {scope: :theme}
end
