class CreateThemes < ActiveRecord::Migration[6.1]
  def change
    create_table :themes do |t|
      t.integer :end_user_id, null: false
      t.string :title, null: false
      t.text :detail
      t.string :tag # , null: false
      t.timestamps
    end
  end
end
