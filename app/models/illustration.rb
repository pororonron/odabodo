class Illustration < ApplicationRecord
  belongs_to :end_user
  belongs_to :theme
  belongs_to :challenge_theme
end
