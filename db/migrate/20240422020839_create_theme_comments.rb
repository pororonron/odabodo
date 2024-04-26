class CreateThemeComments < ActiveRecord::Migration[6.1]
  def change
    create_table :theme_comments do |t|
      t.references :end_user, null: false, foreign_key: true
      t.references :theme, null: false, foreign_key: true
      t.text :comment, null: false

      t.timestamps
    end
  end
end
