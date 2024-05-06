class CreateThemes < ActiveRecord::Migration[6.1]
  def change
    create_table :themes do |t|
      t.integer :end_user_id, null: false
      t.string :title, null: false, default: '無題'
      t.text :detail
      t.timestamps
    end
  end
end
