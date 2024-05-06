class Favorite < ApplicationRecord
  belongs_to :end_user
  belongs_to :illustration

  validates :end_user_id, uniqueness: {scope: :illustration_id}
end
