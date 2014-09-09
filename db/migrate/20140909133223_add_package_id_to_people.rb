class AddPackageIdToPeople < ActiveRecord::Migration
  def change
    add_column :people, :package_id, :integer
  end
end
