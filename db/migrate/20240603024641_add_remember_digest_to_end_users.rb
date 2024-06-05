class AddRememberDigestToEndUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :end_users, :remember_digest, :string
  end
end
