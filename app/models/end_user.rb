class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  GUEST_END_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_END_USER_EMAIL) do |end_user|
      end_user.password = SecureRandom.urlsafe_base64
      end_user.name = "ゲスト"
    end
  end
end
