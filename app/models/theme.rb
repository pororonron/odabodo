class Theme < ApplicationRecord
  has_many_attached :reference_images
  belongs_to :end_user
  has_many :theme_tag_middles, dependent: :destroy
  has_many :theme_tags, through: :theme_tag_middles
  has_many :challenge_themes, dependent: :destroy
  has_many :theme_comments, dependent: :destroy
  has_many :illustrations, dependent: :destroy

  validates :title, presence: true,
    length: { maximum: 30 }
  validates :detail,
    length: { maximum: 1000 }
  validate :require_theme_tags

  attr_writer :theme_tag_name

  after_create :save_theme_tags
  after_update :update_theme_tags

  def save_theme_tags
    theme_tag_names = @theme_tag_name.split(" ").uniq
    theme_tag_names.each do |new_theme_tag|
      if ThemeTag.exists?(name: new_theme_tag)
        theme_tag = ThemeTag.find_by(name: new_theme_tag)
        ThemeTagMiddle.create(theme_id: self.id, theme_tag_id: theme_tag.id)
      else
        self.theme_tags.create(name: new_theme_tag)
      end
    end
  end

  def update_theme_tags
    if self.is_active
      theme_tags.destroy_all
      save_theme_tags
    end
  end

  def theme_tag_name
    theme_tags.pluck(:name).join(" ")
  end

  def theme_challenged_by?(end_user)
    challenge_themes.exists?(end_user_id: end_user.id)
  end

  def require_theme_tags
    if @theme_tag_name.blank?
      errors.add(:theme_tag_name, "タグは必須です")
    end
  end

end
