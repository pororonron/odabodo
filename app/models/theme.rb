class Theme < ApplicationRecord
  has_one_attached :reference_image
  validates :name,
    length: { maximum: 30 }
  validates :introduction,
    length: { maximum: 1000 }

  def get_reference_image(width, height)
    unless reference_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      reference_image.attach(io: File.open(file_path), filename: 'no-image.jpg', content_type: 'image/jpeg')
    end
    reference_image.variant(resize_to_limit: [width, height]).processed
  end
end
