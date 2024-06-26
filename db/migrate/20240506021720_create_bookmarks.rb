class CreateBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarks do |t|
      t.references :end_user, null: false, foreign_key: true
      t.references :illustration, null: false, foreign_key: true

      t.timestamps
    end
  end
end
