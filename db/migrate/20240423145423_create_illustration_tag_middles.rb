class CreateIllustrationTagMiddles < ActiveRecord::Migration[6.1]
  def change
    create_table :illustration_tag_middles do |t|
      t.references :illustration, null: false, foreign_key: true
      t.references :illustration_tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
