class RemoveTagFromThemes < ActiveRecord::Migration[6.1]
  def change
    remove_column :themes, :tag, :string
  end
end
