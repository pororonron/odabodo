class CreateIllustrations < ActiveRecord::Migration[6.1]
  def change
    create_table :illustrations do |t|
      t.references :end_user, null: false, foreign_key: true
      t.references :theme, null: false, foreign_key: true
      t.references :challenge_theme, null: false, foreign_key: true
      t.string :title, null: false, default: "無題"
      t.text :detail

      t.timestamps
    end
  end
end
