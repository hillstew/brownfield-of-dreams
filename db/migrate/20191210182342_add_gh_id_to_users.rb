class AddGhIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :gh_id, :integer
  end
end
