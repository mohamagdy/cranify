class AddPublicationDateToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :publication_date, :date
  end
end
