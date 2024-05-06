class Illustration < ApplicationRecord
  has_many_attached :challenged_images
  belongs_to :end_user
  belongs_to :theme
  has_many :illustration_tag_middles, dependent: :destroy
  has_many :illustration_tags, through: :illustration_tag_middles
  has_many :illustration_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  validates :title, presence: true,
    length: { maximum: 30 }
  validates :detail,
    length: { maximum: 1000 }

  validate :require_illustration_tags


  attr_writer :illustration_tag_name, :select_theme

  after_create :save_illustration_tags
  after_update :update_illustration_tags

  def save_illustration_tags
    illustration_tag_names = @illustration_tag_name.split(',')
    illustration_tag_names.each do |new_illustration_tag|
      self.illustration_tags.find_or_create_by(name: new_illustration_tag)
    end
  end

  def update_illustration_tags
    illustration_tags.destroy_all
    save_illustration_tags
  end

  def illustration_tag_name
    illustration_tags.pluck(:name).join(",")
  end

  def favorited_by?(end_user)
    favorites.exists?(end_user_id: end_user.id)
  end

  def bookmarked_by?(end_user)
    bookmarks.exists?(end_user_id: end_user.id)
  end

  private

  def require_illustration_tags
    if @illustration_tag_name.blank?
      errors.add(:illustration_tag_name, "タグは必須です")
    end
  end
  
  def self.looks(word)
    @illustration = Illustration.where("title LIKE?", "#{word}")
  end
end
