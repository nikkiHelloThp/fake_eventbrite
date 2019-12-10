class AddIsSuperAdminToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_super_admin, :boolean, default: false
  end
end
