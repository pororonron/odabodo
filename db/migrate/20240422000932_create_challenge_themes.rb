class CreateChallengeThemes < ActiveRecord::Migration[6.1]
  def change
    create_table :challenge_themes do |t|
      t.references :end_user, foreign_key: true, null: false
      t.references :theme, foreign_key: true, null: false

      t.timestamps
    end
  end
end
