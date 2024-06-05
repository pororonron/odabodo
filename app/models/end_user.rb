class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_image
  has_many :themes, dependent: :destroy
  has_many :challenge_themes, lambda { joins(:theme).where(theme: {is_active: true}) }, dependent: :destroy
  has_many :theme_comments, dependent: :destroy
  has_many :illustrations, dependent: :destroy
  has_many :illustration_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :followers, class_name: "FollowRelationship", foreign_key: "follower_id", dependent: :destroy
  has_many :follows, class_name: "FollowRelationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_end_users, through: :followers, source: :followed
  has_many :follower_end_users, through: :follows, source: :follower
  validates :name, presence: true,
    length: { maximum: 30 }
  validates :self_introduction,
    length: { maximum: 1000 }
  GUEST_END_USER_EMAIL = "guest@example.com"

  attr_accessor :remember_token
  
  def EndUser.new_token
    SecureRandom.urlsafe_base64
  end
  
  def EndUser.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def remember
    self.remember_token = EndUser.new_token
    update_attribute(:remember_digest, EndUser.digest(remember_token))
  end
  
  def self.guest
    find_or_create_by!(email: GUEST_END_USER_EMAIL) do |end_user|
      end_user.password = SecureRandom.urlsafe_base64
      end_user.name = "ゲスト"
    end
  end

  def guest_end_user?
    email == GUEST_END_USER_EMAIL
  end

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_end_user_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'no-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def follow(end_user_id)
    followers.create(followed_id: end_user_id)
  end

  def unfollow(end_user_id)
    followers.find_by(followed_id: end_user_id).destroy
  end

  def following?(end_user)
    following_end_users.include?(end_user)
  end
  
  def end_user_status
    if is_active == true
      "有効"
    else
      "退会"
    end
  end
  
end
