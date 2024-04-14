class CreateThemeTagMiddles < ActiveRecord::Migration[6.1]
  def change
    create_table :theme_tag_middles do |t|
      t.references :theme, foreign_key: true, null: false
      t.references :theme_tag, foreign_key: true, null: false
      t.timestamps
    end
  end
end
