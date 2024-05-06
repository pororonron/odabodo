class ChallengeTheme < ApplicationRecord
  belongs_to :end_user
  belongs_to :theme
  has_many :illustrations, dependent: :destroy
  validates :end_user_id, uniqueness: {scope: :theme_id}

  def self.theme
    pluck(:theme_id)
  end
end
