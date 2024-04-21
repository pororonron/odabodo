class AddThemeTagIdToThemes < ActiveRecord::Migration[6.1]
  def change
    add_column :themes, :theme_tag_id, :integer
  end
end
