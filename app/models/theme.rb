class Theme < ApplicationRecord
  has_one_attached :reference_image
  belongs_to :end_user
  has_many :theme_tag_middles, dependent: :destroy
  has_many :theme_tags, through: :theme_tag_middles
  validates :title,
    length: { maximum: 30 }
  validates :detail,
    length: { maximum: 1000 }

  def get_reference_image(width, height)
    unless reference_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      reference_image.attach(io: File.open(file_path), filename: 'no-image.jpg', content_type: 'image/jpeg')
    end
    reference_image.variant(resize_to_limit: [width, height]).processed
  end

  def save_theme_tags(theme_tags)
    theme_tags.each do |new_theme_tag|
      self.theme_tags.find_or_create_by(name: new_theme_tag)
    end
  end

  def update_theme_tags(theme_tags)
    registered_theme_tags = theme_tags.pluck(:name)
  end
end
