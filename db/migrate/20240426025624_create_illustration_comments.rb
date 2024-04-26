class CreateIllustrationComments < ActiveRecord::Migration[6.1]
  def change
    create_table :illustration_comments do |t|
      t.references :end_user, null: false, foreign_key: true
      t.references :illustration, null: false, foreign_key: true
      t.text :comment, null: false

      t.timestamps
    end
  end
end
