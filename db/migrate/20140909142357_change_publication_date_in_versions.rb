class ChangePublicationDateInVersions < ActiveRecord::Migration
  def up
    change_column :versions, :publication_date, :string
  end

  def down
    change_column :versions, :publication_date, :date
  end
end
