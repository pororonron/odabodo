class RemoveThemeTagIdFromThemes < ActiveRecord::Migration[6.1]
  def change
    remove_column :themes, :theme_tag_id, :integer
  end
end
