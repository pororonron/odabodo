class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_image
  has_many :themes, dependent: :destroy
  has_many :challenge_themes, dependent: :destroy
  has_many :theme_comments, dependent: :destroy
  has_many :illustrations, dependent: :destroy
  has_many :illustration_comments, dependent: :destroy
  validates :name, presence: true,
    length: { maximum: 30 }
  validates :self_introduction,
    length: { maximum: 1000 }
  GUEST_END_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_END_USER_EMAIL) do |end_user|
      end_user.password = SecureRandom.urlsafe_base64
      end_user.name = "ゲスト"
    end
  end

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_end_user_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'no-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
