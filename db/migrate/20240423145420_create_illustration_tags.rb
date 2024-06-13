class CreateIllustrationTags < ActiveRecord::Migration[6.1]
  def change
    create_table :illustration_tags do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
