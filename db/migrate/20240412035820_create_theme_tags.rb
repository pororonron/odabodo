class CreateThemeTags < ActiveRecord::Migration[6.1]
  def change
    create_table :theme_tags do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
